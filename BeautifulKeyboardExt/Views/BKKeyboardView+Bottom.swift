//
//  BKKeyboardView+Create.swift
//  BeautifulKeyboard
//
//  Created by Nguyen Tuan on 1/21/17.
//  Copyright © 2017 tuan. All rights reserved.
//

import UIKit

extension BKKeyboardView {

    func createBottomLeftView() -> BKGridView {
        let fncBtn1 = BKKey.functionKey(with: .symbol1)
        let fncBtn2 = BKKey.functionKey(with: .symbol2)
        let fncBtn3 = BKKey.functionKey(with: .numeric)
        let fncBtn4 = BKKey.functionKey(with: .shift)
        let fncBtn5 = BKKey.functionKey(with: .micro)
        let fncBtn6 = BKKey.functionKey(with: .switchKeyboard)
        
        let gridLeft = BKGridView(withButtons: [fncBtn1, fncBtn2, fncBtn3, fncBtn4, fncBtn5, fncBtn6], row: 2, col: 3)

        gridLeft.horizontalPadding = 4
        gridLeft.verticalPadding = 3
        gridLeft.translatesAutoresizingMaskIntoConstraints = false
        
        self.keyPadController.register(keys: [fncBtn1, fncBtn2, fncBtn3, fncBtn4, fncBtn5, fncBtn6])
        
        return gridLeft
    }
    
    func createBottomMidView() -> BKGridView {
        let keyD = self.keyPadController.activeKeyboard().keyD().create()
        let fncBtn2 = self.keyPadController.activeKeyboard().keySpace().create()
        fncBtn2.dispalySmallPic = false //overwrite this because we want to show a full image for this button
        
        let view = BKGridView(withButtons: [keyD, fncBtn2], row: 2, col: 1)

        view.horizontalPadding = 4
        view.verticalPadding = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.keyPadController.register(keys: [keyD, fncBtn2])
        
        return view
    }
    
    func createBottomRightView() -> BKGridView {
        let fncBtn1 = BKKey.functionKey(with: .symbol3)
        let fncBtn2 = BKKey.functionKey(with: .symbol4)
        let fncBtn3 = BKKey.functionKey(with: .net)
        let fncBtn4 = BKKey.functionKey(with: .edit)
        let fncBtn5 = BKKey.functionKey(with: .ret)
        let fncBtn6 = BKKey.functionKey(with: .del)
        
        let view = BKGridView(withButtons: [fncBtn1, fncBtn2, fncBtn3, fncBtn4, fncBtn5, fncBtn6], row: 2, col: 3)

        view.horizontalPadding = 4
        view.verticalPadding = 3
        view.translatesAutoresizingMaskIntoConstraints = false

        self.keyPadController.register(keys: [fncBtn1, fncBtn2, fncBtn3, fncBtn4, fncBtn5, fncBtn6])
        
        return view
    }
    
}
