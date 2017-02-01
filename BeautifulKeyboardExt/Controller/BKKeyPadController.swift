//
//  BKKeyController.swift
//  BeautifulKeyboard
//
//  Created by Nguyen Tuan on 1/21/17.
//  Copyright © 2017 tuan. All rights reserved.
//

import UIKit

protocol BKKeyPadProtocol {
    func didTapFunctionKey(type: BKKeyFunctionType)
    func didTapKey(letter: String)
}

class BKKeyPadController: NSObject {
    var totalKeys = [BKKey]()
    var delegate: BKKeyPadProtocol?
    private let englishKeyboard = BKEnKeyboard()
    
    private var shiftEnabled = false
    private var alternateEnabled = false
    
    func register(key: BKKey) {
        key.addTarget(self, action: #selector(BKKeyPadController.handleKeyTap(sender:)), for: .touchUpInside)
        
        totalKeys.append(key)
    }
    
    func register(keys: [BKKey]) {
        for k in keys {
            register(key: k)
        }
    }
    
    func activeKeyboard() -> BKKeyboard {
        return englishKeyboard
    }
    
    func getKey(by functionType: BKKeyFunctionType) -> BKKey? {
        return totalKeys.filter({functionType == $0.type}).first
    }
    
    func getKey(by value: String) -> BKKey? {
        return totalKeys.filter({(value.lowercased() == $0.value?.lowercased()
                                    || value.lowercased() == $0.altValue?.lowercased())}).first
    }
    
    //MARK: Configure
    func switchShiftOption() {
        shiftEnabled = !shiftEnabled
    }
    
    func getShiftOption() -> Bool {
        return shiftEnabled
    }
    
    func switchAlternativeOption() {
        alternateEnabled = !alternateEnabled
    }
    
    func getAlternativeOption() -> Bool {
        return alternateEnabled
    }
    
    //MARK: Actions
    func handleKeyTap(sender: BKKey) {
        if sender.isFunctionKey {
            guard let type = sender.type else {
                return
            }
            delegate?.didTapFunctionKey(type: type)
        }else {
            if alternateEnabled {
                if let v = sender.getAlternativeValue() {
                    delegate?.didTapKey(letter: v)
                }else if let v = sender.getValue(shift: shiftEnabled) {
                    delegate?.didTapKey(letter: v)
                }
            }else {
                if let value = sender.getValue(shift: shiftEnabled) {
                    delegate?.didTapKey(letter: value)
                }
            }
        }
    }
}
