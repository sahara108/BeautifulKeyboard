//
//  BKKeyboardView+Top.swift
//  BeautifulKeyboard
//
//  Created by Nguyen Tuan on 1/22/17.
//  Copyright © 2017 tuan. All rights reserved.
//

import UIKit

extension BKKeyboardView {
    func createRow1() -> BKGridView {
        let keyK = self.keyPadController.activeKeyboard().keyK().create()
        let keyW = self.keyPadController.activeKeyboard().keyW().create()
        let keyL = self.keyPadController.activeKeyboard().keyL().create()
        let keyF = self.keyPadController.activeKeyboard().keyF().create()
        let keyB = self.keyPadController.activeKeyboard().keyB().create()
        
        let view = BKGridView(withButtons: [keyK, keyW, keyL, keyF, keyB], row:1, col: 5)

        view.translatesAutoresizingMaskIntoConstraints = false

        self.keyPadController.register(keys: [keyK, keyW, keyL, keyF, keyB])
        
        return view
    }
    
    func createRow2() -> BKGridView {
        let keyJ = self.keyPadController.activeKeyboard().keyJ().create()
        let keyQ = self.keyPadController.activeKeyboard().keyQ().create()
        let keyV = self.keyPadController.activeKeyboard().keyV().create()
        let keyX = self.keyPadController.activeKeyboard().keyX().create()
        
        let view = BKGridView(withButtons: [keyJ, keyQ, keyV, keyX], row:1, col: 4)
        view.translatesAutoresizingMaskIntoConstraints = false

        self.keyPadController.register(keys: [keyJ, keyQ, keyV, keyX])
        
        return view
    }
    
    func createRow3() -> BKGridView {
        let keyC = self.keyPadController.activeKeyboard().keyC().create()
        let keyT = self.keyPadController.activeKeyboard().keyT().create()
        let keyI = self.keyPadController.activeKeyboard().keyI().create()
        let keyO = self.keyPadController.activeKeyboard().keyO().create()
        let keyU = self.keyPadController.activeKeyboard().keyU().create()
        
        let view = BKGridView(withButtons: [keyC, keyT, keyI, keyO, keyU], row:1, col: 5)
        view.translatesAutoresizingMaskIntoConstraints = false

        self.keyPadController.register(keys: [keyC, keyT, keyI, keyO, keyU])
        
        return view
    }
    
    func createRow4() -> BKGridView {
        let keyZ = self.keyPadController.activeKeyboard().keyZ().create()
        let keySpace1 = self.keyPadController.activeKeyboard().keySmallSpace().create()
        let keySpace2 = self.keyPadController.activeKeyboard().keySmallSpace().create()
        
        let view = BKGridView(withButtons: [keyZ, keySpace1, keySpace2], row:1, col: 4)
        view.translatesAutoresizingMaskIntoConstraints = false

        self.keyPadController.register(keys: [keyZ, keySpace1, keySpace2])
        
        return view
    }
    
    func createRow5() -> BKGridView {
        let keyM = self.keyPadController.activeKeyboard().keyM().create()
        let keyS = self.keyPadController.activeKeyboard().keyS().create()
        let keyA = self.keyPadController.activeKeyboard().keyA().create()
        let keyN = self.keyPadController.activeKeyboard().keyN().create()
        let keyY = self.keyPadController.activeKeyboard().keyY().create()
        
        let view = BKGridView(withButtons: [keyM, keyS, keyA, keyN, keyY], row:1, col: 5)
        view.translatesAutoresizingMaskIntoConstraints = false

        self.keyPadController.register(keys: [keyM, keyS, keyA, keyN, keyY])
        
        return view
    }
    
    func createRow6() -> BKGridView {
        let keyP = self.keyPadController.activeKeyboard().keyP().create()
        let keyH = self.keyPadController.activeKeyboard().keyH().create()
        let keyE = self.keyPadController.activeKeyboard().keyE().create()
        let keyR = self.keyPadController.activeKeyboard().keyR().create()
        let keyG = self.keyPadController.activeKeyboard().keyG().create()
        
        let view = BKGridView(withButtons: [keyP, keyH, keyE, keyR, keyG], row:1, col: 5)
        view.translatesAutoresizingMaskIntoConstraints = false

        self.keyPadController.register(keys: [keyP, keyH, keyE, keyR, keyG])
        
        return view
    }
}
