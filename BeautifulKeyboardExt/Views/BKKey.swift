//
//  BKButton.swift
//  BeautifulKeyboard
//
//  Created by Nguyen Tuan on 1/22/17.
//  Copyright © 2017 tuan. All rights reserved.
//

import UIKit

class BKKey: UIButton {
    var value: String?
    var altValue: String?
    
    var isFunctionKey = false
    var type : BKKeyFunctionType?
    var dispalySmallPic = true
    
    
    class func functionKey(with type: BKKeyFunctionType) -> BKKey {
        let key = BKKey(type: .custom)
        key.setImage(UIImage(named: type.rawValue), for: .normal)
        key.isFunctionKey = true
        key.type = type
        key.dispalySmallPic = false
        
        return key
    }
    
    class func normalKey(keyInput: BKKeyInput) -> BKKey {
        let key = BKKey(type: .custom)
        key.setImage(UIImage(named: keyInput.imageName), for: .normal)
        key.isFunctionKey = false
        key.value = keyInput.value
        key.altValue = keyInput.altValue
        key.dispalySmallPic = true
        
        return key
    }
    
//    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
//        if !dispalySmallPic {
//            return contentRect
//        }else {
//            let expectedSize = min(contentRect.width * 0.9, contentRect.height * 0.9)
//            let x = (contentRect.width - expectedSize) * 0.5
//            let y = (contentRect.height - expectedSize) * 0.5
//            return CGRect(x: x, y: y, width: expectedSize, height: expectedSize)
//        }
//    }
    
    func getValue(shift: Bool) -> String? {
        return (shift ? value?.uppercased() : value?.lowercased())
    }
    
    func getAlternativeValue() -> String? {
        return altValue
    }
    
    func changeToSelectedMode(mode: Bool) {
        OperationQueue.main.addOperation {
            self.isHighlighted = mode
        }
    }
    
    func tappableArea() -> CGRect {
        if let f = self.imageView?.frame {
            return f
        }
        
        return self.bounds
    }
    
    var pointInTappableArea = 0
    var pointOutTappableArea = 1
}

extension BKKey {
    func beginDrag(at point: CGPoint) {
        guard !self.isFunctionKey else {
            return
        }
        
        pointInTappableArea  = 0
        pointOutTappableArea = 0
        
        if self.tappableArea().contains(point) {
            pointInTappableArea += 1
        }else {
            pointOutTappableArea += 1
        }
    }
    
    func drag(to point: CGPoint) {
        guard !self.isFunctionKey else {
            return
        }
        
        if self.tappableArea().contains(point) {
            pointInTappableArea += 1
        }else {
            pointOutTappableArea += 1
        }
    }
    
    func commitDrag(with action: ((BKKey, Bool) -> ())? ) {
        guard !self.isFunctionKey else {
            return
        }
        
        print("commit drag for button \(self.value) with point in \(self.pointInTappableArea) out \(self.pointOutTappableArea)")
        if pointOutTappableArea > 0 && pointInTappableArea > 0 {
            action?(self, true)
        }else {
            action?(self, false)
        }
    }
    
    func resetDragPoint() {
        pointInTappableArea = 0
        pointOutTappableArea = 0
    }
    
    func dragCrossTappableArea() -> Bool {
        guard !self.isFunctionKey else {
            return false
        }
        
        return pointOutTappableArea > 0 && pointInTappableArea > 0
    }
}
