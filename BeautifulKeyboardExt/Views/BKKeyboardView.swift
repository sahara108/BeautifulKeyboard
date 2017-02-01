//
//  BKKeyboardView.swift
//  BeautifulKeyboard
//
//  Created by Nguyen Tuan on 1/21/17.
//  Copyright © 2017 tuan. All rights reserved.
//

import UIKit

class BKKeyboardView: UIView, DrawPathViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    weak var keyPadController: BKKeyPadController!

    //Need to fix this.
//    var isPortrait: Bool {
//        get {
//            return UIDevice.current.orientation.isPortrait
//        }
//    }
    
    //MARK: drawable view
    var drawableView: DrawPathView?
   
    //MARK: Bottom views
    var leftGridView: BKGridView?
    var rightGridView: BKGridView?
    var middleGridView: BKGridView?
    
    //MARK: Top views
    var topRow1 : BKGridView?
    var topRow2: BKGridView?
    var topRow3: BKGridView?
    var topRow4: BKGridView?
    var topRow5: BKGridView?
    var topRow6: BKGridView?
    
    //MARK: Calculation
    let bottomHFactor: CGFloat = 0.32 //The ratio of the height of bottom function view compare to the keyboard height. It should be adjusted when user rotate the device
    let bottomWFactor: CGFloat = 1/3 // The ratio of the width of bottom function view compare to the keyboard width. It should be adjusted when user rotate the device. Since we only have 3 vies in bottom, so the factor will be 1/3
    
    
    /// Assume we have the keyboard height is h. We leave h * bottomFactor for the bottom function keys view. Remain height will be h * (1 - bottomHFactor)
    /// For this particular keyboard, we have 6 rows, thus the ratio will be h * (1 - bottomHFactor)/6
    ///
    /// - Returns: height factor of each top row
    func heightRatioForEachTopRow() -> CGFloat {
        return (1 - bottomHFactor - 0.05) / 6 // The last row is about 10 pixel upper the bottom views. Keyboard height is around 216 in portrait and 162 in landscape. So I minus 0.05 here for 10 pixel. Need to recalculate for landscape mode
    }
    
    //MARK: prepare
    func preapare(keypad: BKKeyPadController? = nil) {
        self.keyPadController = keypad
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(colorLiteralRed: 0.21, green: 0.28, blue: 0.31, alpha: 1)
        
        self.leftGridView = createBottomLeftView()
        self.middleGridView = createBottomMidView()
        self.rightGridView = createBottomRightView()
                
        self.addSubview(self.leftGridView!)
        self.addSubview(self.middleGridView!)
        self.addSubview(self.rightGridView!)
        
        self.topRow1 = self.createRow1()
        self.topRow2 = self.createRow2()
        self.topRow3 = self.createRow3()
        self.topRow4 = self.createRow4()
        self.topRow5 = self.createRow5()
        self.topRow6 = self.createRow6()
        
        self.addSubview(self.topRow1!)
        self.addSubview(self.topRow2!)
        self.addSubview(self.topRow3!)
        self.addSubview(self.topRow4!)
        self.addSubview(self.topRow5!)
        self.addSubview(self.topRow6!)
        
        
        drawableView = DrawPathView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        drawableView?.translatesAutoresizingMaskIntoConstraints = false
        drawableView?.delegate = self
        self.addSubview(drawableView!)
        
        drawableView?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        drawableView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        drawableView?.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        drawableView?.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        self.configureLayoutContraints()
        
        //Finally setup swiping controller
        setupSwipingController()
    }
    
    private let swipingController: BKSwipingController = BKSwipingController()
    private let swipingOperation = OperationQueue()
    func setupSwipingController() {
        swipingController.keypad = self.keyPadController
        swipingOperation.maxConcurrentOperationCount = 1
        swipingOperation.qualityOfService = .background
    }
    
    override func updateConstraints() {
        super.updateConstraints()

        self.configureLayoutContraints()
    }
    
    func configureLayoutContraints() {
        let x = CGFloat(0)
        let bot = CGFloat(-1)

        if let view = leftGridView {
//            if isPortrait {
//                view.heightAnchor.constraint(equalToConstant: 78).isActive = true
//                view.widthAnchor.constraint(equalToConstant: 112).isActive = true
//            }else {
                view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: bottomHFactor, constant: 0).isActive = true
                view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: bottomWFactor).isActive = true
//            }
            
            view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bot).isActive = true
        }
        
        if let view = middleGridView {
//            if isPortrait {
//                view.heightAnchor.constraint(equalToConstant: 78).isActive = true
//                view.widthAnchor.constraint(equalToConstant: 112).isActive = true
//            }else {
                view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: bottomHFactor, constant: 0).isActive = true
                view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: bottomWFactor).isActive = true
//            }
            
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bot).isActive = true
            
            if let v = leftGridView {
                view.leftAnchor.constraint(equalTo: v.rightAnchor, constant: -4).isActive = true
            }else {
                view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: x).isActive = true
            }
        }
        
        if let view = rightGridView {
//            if isPortrait {
//                view.heightAnchor.constraint(equalToConstant: 78).isActive = true
//                view.widthAnchor.constraint(equalToConstant: 112).isActive = true
//            }else {
                view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: bottomHFactor, constant: 0).isActive = true
                view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: bottomWFactor).isActive = true
//            }
            
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bot).isActive = true
            
            if let v = middleGridView {
                view.leftAnchor.constraint(equalTo: v.rightAnchor, constant: -4).isActive = true
            }else {
                view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: x).isActive = true
            }
        }
        
        //setup top vies
        let f = self.heightRatioForEachTopRow()
        if let view = topRow1 {
//            view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: f, constant: 1).isActive = true
            view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: f, constant: 0).isActive = true
            view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
            view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        }
        
        if let view = topRow2 {
            view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: f * 0.9, constant: 0).isActive = true
            
            if let v = topRow1 {
                view.topAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
                view.widthAnchor.constraint(equalTo: v.widthAnchor, multiplier: 4/5).isActive = true
                view.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
            }else {
                view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
                view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            }
        }
        
        if let view = topRow3 {
            view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: f, constant: 0).isActive = true
            view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
            view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            
            if let v = topRow2 {
                view.topAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
            }else {
                view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            }
        }
        
        if let view = topRow4 {
            view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: f * 0.9, constant: 0).isActive = true
            
            if let v = topRow3 {
                view.topAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
                view.widthAnchor.constraint(equalTo: v.widthAnchor, multiplier: 4/5).isActive = true
                view.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
            }else {
                view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
                view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            }
        }
        
        if let view = topRow5 {
            view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: f, constant: 0).isActive = true
            view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
            view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            
            if let v = topRow4 {
                view.topAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
            }else {
                view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            }
        }
        
        if let view = topRow6 {
            view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: f, constant: 0).isActive = true
            view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
            view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            
            if let v = topRow5 {
//                view.topAnchor.constraint(equalTo: v.bottomAnchor, constai).isActive = true
                view.topAnchor.constraint(equalTo: v.bottomAnchor, constant: 4).isActive = true
            }else {
                view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            }
        }
    }
    
    private var draggingPoint = [CGPoint]()
    private var processingPoints = DispatchQueue(label: "dragingPoint")
    func clearDraggingPoint() {
        processingPoints.sync {
            draggingPoint.removeAll()
        }
    }
    
    func draggingPointAdd(points: [CGPoint]) {
        processingPoints.sync {
            draggingPoint.append(contentsOf: points)
        }
    }
    
    func getPendingDragingPoint() -> [CGPoint] {
        var result = [CGPoint]()
        processingPoints.sync {
            result.append(contentsOf: draggingPoint)
            draggingPoint.removeAll()
        }
        
        return result
    }
    
    //MARK: Drawable delegate
    func viewDrawStartedDrawing(at point: CGPoint) {
        for k in keyPadController.totalKeys {
            let keyFrame = self.convert(k.frame, from: k.superview)
            if keyFrame.contains(point) {
                let pointInBtn = k.convert(point, from: self)
                swipingController.start(at: pointInBtn, inKey: k)
                return
            }
        }
    }
    
    func viewDrawEndedDrawing() {
        swipingController.end()
        clearDraggingPoint()
        drawableView?.clearAll()
    }
    
    func viewDrawContinue(points: [CGPoint]) {
        draggingPointAdd(points: points)
        
        swipingOperation.addOperation {
            let ps = self.getPendingDragingPoint()
            for point in ps {
                for k in self.keyPadController.totalKeys {
                    let keyFrame = self.convert(k.frame, from: k.superview)
                    if keyFrame.contains(point) {
                        let pointInBtn = k.convert(point, from: self)
                        self.swipingController.drag(to: pointInBtn, inKey: k)
                        break
                    }
                }
            }
        }
    }
    
    func shouldHandle(point: CGPoint, with event: UIEvent?) -> Bool {
        for k in keyPadController.totalKeys {
            let keyFrame = self.convert(k.frame, from: k.superview)
            if keyFrame.contains(point) {
                let pointInBtn = k.convert(point, from: self)
                return k.tappableArea().contains(pointInBtn)
            }
        }
        return false
    }
}
