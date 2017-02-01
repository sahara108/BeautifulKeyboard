//
//  BKSwipingController.swift
//  BeautifulKeyboard
//
//  Created by Nguyen Tuan on 1/22/17.
//  Copyright © 2017 tuan. All rights reserved.
//

import UIKit

class BKSwipingController: NSObject {
    weak var keypad: BKKeyPadController!
    
    var workingKey : (BKKey, commited: Bool)?
    var shouldGetValueImmediately = true
    
    func start(at point: CGPoint, inKey: BKKey) {
        workingKey = (inKey, commited: false)
        workingKey?.0.beginDrag(at: point)
    }
    
    func drag(to point: CGPoint, inKey: BKKey) {
        if inKey == workingKey?.0 {
            workingKey!.0.drag(to: point)
            
            if shouldGetValueImmediately {
                if let keyCommited = workingKey?.commited {
                    if !keyCommited && workingKey!.0.dragCrossTappableArea() {
                        workingKey!.commited = true
                        DispatchQueue.main.async {
                            self.keypad.handleKeyTap(sender: inKey)
                        }
                    }
                }
            }
        }else {
            if let keyCommited = workingKey?.commited {
                workingKey?.0.commitDrag(with: { (key, tapped) in
                    if tapped && !keyCommited {
                        DispatchQueue.main.async {
                            self.keypad.handleKeyTap(sender: key)
                        }
                    }
                })
            }
            workingKey = (inKey, commited: false)
            workingKey?.0.beginDrag(at: point)
        }
    }
    
    func end() {
        //reset
        if let key = workingKey?.0 {
            key.resetDragPoint()
        }
        workingKey = nil
    }
}
