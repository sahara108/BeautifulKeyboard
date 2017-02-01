//
//  KeyboardViewController.swift
//  BeautifulKeyboardExt
//
//  Created by Nguyen Tuan on 1/21/17.
//  Copyright © 2017 tuan. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, BKKeyPadProtocol {
    
    let keyPadController = BKKeyPadController()
    var expectedPortraintHeight : CGFloat {
        get {
            let screenWidth = UIScreen.main.bounds.width
            return screenWidth * (272/320)
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyPadController.delegate = self
        
        let deviceOrientation = UIDevice.current.orientation

        if deviceOrientation.isPortrait {
            let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: expectedPortraintHeight)
            self.view.addConstraint(heightConstraint)
        }
        self.view.layer.borderColor = UIColor.gray.cgColor
        self.view.layer.borderWidth = 1
        // Perform custom UI setup here
        let v = BKKeyboardView(frame: self.view.frame)
        v.preapare(keypad: self.keyPadController)
        v.frame = CGRect(x: 0, y: 0, width: 320, height: 180)
        self.view.addSubview(v)
        
        v.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        v.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        v.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        v.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
//        var textColor: UIColor
//        let proxy = self.textDocumentProxy
//        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
//            textColor = UIColor.white
//        } else {
//            textColor = UIColor.black
//        }
//        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

    //MARK: Keypad protocol
    func didTapKey(letter: String) {
        let proxy = self.textDocumentProxy
        proxy.insertText(letter)
    }
    
    func didTapFunctionKey(type: BKKeyFunctionType) {
        switch type {
        case .switchKeyboard:
            self.advanceToNextInputMode()
        case .shift:
            self.keyPadController.switchShiftOption()
            //TODO: tell the keyboard to update its ui
            if let keyBtn = keyPadController.getKey(by: .shift) {
                keyBtn.changeToSelectedMode(mode: keyPadController.getShiftOption())
            }
        case .numeric:
            self.keyPadController.switchAlternativeOption()
            if let key = keyPadController.getKey(by: .numeric) {
                key.changeToSelectedMode(mode: keyPadController.getAlternativeOption())
            }
        case .del:
            let proxy = self.textDocumentProxy
            proxy.deleteBackward()
        case .ret:
            let proxy = self.textDocumentProxy
            proxy.insertText("\n")
        default:
            print("aa")
        }
    }
}
