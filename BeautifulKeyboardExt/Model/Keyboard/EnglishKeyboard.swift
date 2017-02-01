//
//  BKKeyboard.swift
//  BeautifulKeyboard
//
//  Created by Nguyen Tuan on 1/22/17.
//  Copyright © 2017 tuan. All rights reserved.
//

import UIKit

struct BKEnKeyboard: BKKeyboard {
    func keyA() -> BKKeyInput {
        return BKKeyInput(imageName: "key_017", selectedImageName: nil, value: "a", altValue: "8")
    }
    
    func keyB() -> BKKeyInput {
        return BKKeyInput(imageName: "key_005", selectedImageName: nil, value: "b", altValue: nil)
    }
    
    func keyC() -> BKKeyInput {
        return BKKeyInput(imageName: "key_013", selectedImageName: nil, value: "c", altValue: nil)
    }
    
    func keyD() -> BKKeyInput {
        return BKKeyInput(imageName: "key_001", selectedImageName: nil, value: "d", altValue: nil)
    }
    
    func keyE() -> BKKeyInput {
        return BKKeyInput(imageName: "key_015", selectedImageName: nil, value: "e", altValue: "0")
    }
    
    func keyF() -> BKKeyInput {
        return BKKeyInput(imageName: "key_006", selectedImageName: nil, value: "f", altValue: "3")
    }
    
    func keyG() -> BKKeyInput {
        return BKKeyInput(imageName: "key_002", selectedImageName: nil, value: "g", altValue: nil)
    }
    
    func keyH() -> BKKeyInput {
        return BKKeyInput(imageName: "key_010", selectedImageName: nil, value: "h", altValue: "*")
    }
    
    func keyI() -> BKKeyInput {
        return BKKeyInput(imageName: "key_020", selectedImageName: nil, value: "i", altValue: "5")
    }
    
    func keyJ() -> BKKeyInput {
        return BKKeyInput(imageName: "key_sm_006", selectedImageName: nil, value: "j", altValue: nil)
    }
    
    func keyK() -> BKKeyInput {
        return BKKeyInput(imageName: "key_014", selectedImageName: nil, value: "k", altValue: nil)
    }
    
    func keyL() -> BKKeyInput {
        return BKKeyInput(imageName: "key_007", selectedImageName: nil, value: "l", altValue: "2")
    }
    
    func keyM() -> BKKeyInput {
        return BKKeyInput(imageName: "key_012", selectedImageName: nil, value: "m", altValue: nil)
    }
    
    func keyN() -> BKKeyInput {
        return BKKeyInput(imageName: "key_004", selectedImageName: nil, value: "n", altValue: "9")
    }
    
    func keyO() -> BKKeyInput {
        return BKKeyInput(imageName: "key_019", selectedImageName: nil, value: "o", altValue: "6")
    }
    
    func keyP() -> BKKeyInput {
        return BKKeyInput(imageName: "key_011", selectedImageName: nil, value: "p", altValue: nil)
    }
    
//    func keyG() -> BKKeyInput {
//        return BKKeyInput(imageName: "key_002", selectedImageName: nil, value: "g", altValue: nil)
//    }
    
    func keyQ() -> BKKeyInput {
        return BKKeyInput(imageName: "key_sm_005", selectedImageName: nil, value: "q", altValue: nil)
    }
    
    func keyR() -> BKKeyInput {
        return BKKeyInput(imageName: "key_003", selectedImageName: nil, value: "r", altValue: "#")
    }
    
    func keyS() -> BKKeyInput {
        return BKKeyInput(imageName: "key_009", selectedImageName: nil, value: "s", altValue: "7")
    }
    
    func keyT() -> BKKeyInput {
        return BKKeyInput(imageName: "key_008", selectedImageName: nil, value: "t", altValue: "4")
    }
    
    func keyU() -> BKKeyInput {
        return BKKeyInput(imageName: "key_018", selectedImageName: nil, value: "u", altValue: nil)
    }
    
    func keyV() -> BKKeyInput {
        return BKKeyInput(imageName: "key_sm_004", selectedImageName: nil, value: "v", altValue: nil)
    }
    
    func keyW() -> BKKeyInput {
        return BKKeyInput(imageName: "key_021", selectedImageName: nil, value: "w", altValue: "1")
    }
    
    func keyX() -> BKKeyInput {
        return BKKeyInput(imageName: "key_sm_003", selectedImageName: nil, value: "x", altValue: nil)
    }
    
    func keyY() -> BKKeyInput {
        return BKKeyInput(imageName: "key_016", selectedImageName: nil, value: "y", altValue: nil)
    }
    
    func keyZ() -> BKKeyInput {
        return BKKeyInput(imageName: "key_sm_002", selectedImageName: nil, value: "z", altValue: nil)
    }
    
    func keySmallSpace() -> BKKeyInput {
        return BKKeyInput(imageName: "key_sm_001", selectedImageName: nil, value: " ", altValue: nil)
    }
    
    func keySpace() -> BKKeyInput {
        return BKKeyInput(imageName: "fun_key_space_bar", selectedImageName: nil, value: " ", altValue: nil)
    }
}
