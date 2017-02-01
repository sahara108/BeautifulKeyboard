//
//  BKKeyboardModel.swift
//  BeautifulKeyboard
//
//  Created by Nguyen Tuan on 1/21/17.
//  Copyright © 2017 tuan. All rights reserved.
//

import UIKit

enum BKKeyFunctionType : String {
    case symbol1  = "fun_key_011"                   // I don't know how to call this. It is !?~ button
    case symbol2  = "fun_key_010"                   // I don't know how to call this. It is .,^ button
    case numeric  = "fun_key_009" // 123Symbol
    case symbol3  = "fun_key_006" // ()/
    case symbol4  = "fun_key_005" // '":
    case net      = "fun_key_004" // @.com
    case shift    = "fun_key_012" // shift button
    case micro    = "fun_key_008" // mirco button
    case switchKeyboard = "fun_key_007"
    case edit     = "fun_key_003"
    case ret      = "fun_key_002" // return button (enter)
    case del      = "fun_key_001" // delete button
}

struct BKKeyInput {
    var imageName: String
    var selectedImageName: String?
    var value: String
    var altValue: String?
    
    func create() -> BKKey {
        return BKKey.normalKey(keyInput: self)
    }
}

protocol BKKeyboard {
    func keyA() -> BKKeyInput
    
    func keyB() -> BKKeyInput
    
    func keyC() -> BKKeyInput
    
    func keyD() -> BKKeyInput
    
    func keyE() -> BKKeyInput
    
    func keyF() -> BKKeyInput
    
    func keyG() -> BKKeyInput
    
    func keyH() -> BKKeyInput
    
    func keyI() -> BKKeyInput
    
    func keyJ() -> BKKeyInput
    
    func keyK() -> BKKeyInput
    
    func keyL() -> BKKeyInput
    
    func keyM() -> BKKeyInput
    
    func keyN() -> BKKeyInput
    
    func keyO() -> BKKeyInput
    
    func keyP() -> BKKeyInput
    
    func keyQ() -> BKKeyInput
    
    func keyR() -> BKKeyInput
    
    func keyS() -> BKKeyInput
    
    func keyT() -> BKKeyInput
    
    func keyU() -> BKKeyInput
    
    func keyV() -> BKKeyInput
    
    func keyW() -> BKKeyInput
    
    func keyX() -> BKKeyInput
    
    func keyY() -> BKKeyInput
    
    func keyZ() -> BKKeyInput
    
    func keySmallSpace() -> BKKeyInput
    
    func keySpace() -> BKKeyInput
}

class BKKeyLayout {
    var key: BKKey
    weak var left: BKKeyLayout?
    weak var right: BKKeyLayout?
    weak var top: BKKeyLayout?
    weak var bot: BKKeyLayout?
    
    init(k: BKKey) {
        key = k
    }
}
