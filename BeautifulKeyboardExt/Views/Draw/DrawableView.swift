//
//  DrawableView.swift
//  BeautifulKeyboard
//
//  Created by Nguyen Tuan on 1/22/17.
//  Copyright © 2017 tuan. All rights reserved.
//

import UIKit
import Foundation

/// This code is copied from https://github.com/ahmetkgunay/DrawPathView/blob/master/DrawPathView.swift I just convert it to swift3 and modify it to draw over a transparent view

public protocol DrawPathViewDelegate {
    /// Triggered when user just started  drawing
    func viewDrawStartedDrawing(at point: CGPoint)
    /// Triggered when user just finished  drawing
    func viewDrawEndedDrawing()
    /// Triggered when user continue drawing
    func viewDrawContinue(points: [CGPoint])
    
    /// Ask superview if they want to handle the touch event
    func shouldHandle(point: CGPoint, with event: UIEvent?) -> Bool
}

public class DrawPathView: UIView {
    
    /// A counter to determine if there are enough points to make a quadcurve
    private var ctr = 0
    
    /// The path to stroke
    private var path : UIBezierPath?
    
    /// After the user lifts their finger and the line has been finished the same line is rendered to an image and the UIBezierPath is cleared to prevent performance degradation when lots of lines are on screen
    private var incrementalImage : UIImage?
    
    /// Initial Image If user needs to draw lines on image firstly
    private var initialImage : UIImage?
    
    /// This array stores the points that make each line
    private lazy var pts = Array<CGPoint!>(repeating: nil, count: 5)
    
    public var delegate : DrawPathViewDelegate?
    
    /// Stroke color of drawing path, default is red.
    private var strokeColor = UIColor.red
    
    /// Stores all ımages to get back to last - 1 image. Becase erase last needs this :)
    private var allImages = Array<UIImage>()
    
    // MARK: - Initialize -
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.isMultipleTouchEnabled = true
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        
        createPath()
    }
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        self.isMultipleTouchEnabled = true
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        
        createPath()
    }
    
    public init(initialImage: UIImage) {
        self.init()
        self.incrementalImage = initialImage
        self.initialImage = initialImage;
        self.isMultipleTouchEnabled = true
        self.isOpaque = false
        self.backgroundColor = UIColor.clear
        
        if let img = incrementalImage {
            img.draw(in: self.bounds)
        }
        createPath()
    }
    
    // MARK: - Setup -
    
    private func createPath() {
        path = UIBezierPath()
        path!.lineWidth = 2
    }
    
    /// Erases All paths
    public func clearAll() {
        allImages.removeAll()
        ctr = 0
        path?.removeAllPoints()
        path = nil
        incrementalImage = initialImage
        createPath()
        setNeedsDisplay()
    }
    
    /// Erases Last Path
    public func clearLast() {
        if allImages.count == 0 {
            return
        }
        ctr = 0
        path?.removeAllPoints()
        path = nil
        allImages.removeLast()
        incrementalImage = allImages.last
        createPath()
        setNeedsDisplay()
    }
    
    // MARK: - Change Stroke Color -
    
    public func changeStrokeColor(color:UIColor!) {
        strokeColor = color
    }
    
    // MARK: - Draw Method -
    
    override public func draw(_ rect: CGRect) {
        if let img = incrementalImage {
            img.draw(in: rect)
            strokeColor.setStroke()
            if let pth = path {
                pth.stroke()
            }
        } else {
            //            let rectPth = UIBezierPath(rect: self.bounds)
            //            UIColor.white.withAlphaComponent(0.5).setFill()
            //
            //            rectPth.fill()
        }
    }
    
    // MARK: - Touch Events -
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let v = delegate?.shouldHandle(point: point, with: event) {
            return !v
        }
        
        return true
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ctr = 0
        let touch =  touches.first
        let p = (touch?.location(in: self))!
        
        delegate?.viewDrawStartedDrawing(at: p)
        pts[0] = p
        if let pth = path {
            pth.move(to: p)
        }
        drawBitmap(endDrawing: false)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch =  touches.first
        let p = (touch?.location(in: self))!
        ctr += 1
        pts[ctr] = p
        
        if ctr == 4 {
            // move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment
            pts[3] = CGPoint(x: (pts[2].x + pts[4].x)/2.0, y: (pts[2].y + pts[4].y)/2.0)//CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0)
            if let pth = path {
                pth.move(to: pts[0])
                pth.addCurve(to: pts[3], controlPoint1: pts[1], controlPoint2: pts[2])
            }
            setNeedsDisplay()
            pts[0] = pts[3]
            pts[1] = pts[4]
            
            delegate?.viewDrawContinue(points: pts)
            ctr = 1
        }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        touchesEnded(touches!, with: event)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.viewDrawEndedDrawing()
        
        drawBitmap(endDrawing: true)
        setNeedsDisplay()
        if let pth = path {
            pth.removeAllPoints()
        }
        ctr = 0
    }
    
    // MARK: - Bitmap -
    
    private func drawBitmap(endDrawing:Bool) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        draw(self.bounds)
        if let pth = path {
            pth.stroke()
        }
        incrementalImage = UIGraphicsGetImageFromCurrentImageContext()
        if endDrawing {
            if let _ = incrementalImage {
                allImages.append(incrementalImage!)
            }
        }
        UIGraphicsEndImageContext()
    }
}
