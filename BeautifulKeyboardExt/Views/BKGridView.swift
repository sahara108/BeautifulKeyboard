//
//  BKGridView.swift
//  BeautifulKeyboard
//
//  Created by Nguyen Tuan on 1/22/17.
//  Copyright © 2017 tuan. All rights reserved.
//

import UIKit

class BKGridView : UIView {
    var containButtons = [UIView]()
    var verticalPadding : CGFloat = 1
    var horizontalPadding: CGFloat = 1
    
    var numRow: UInt = 1
    var numCol: UInt = 1
    
    convenience init(withButtons: [UIView], row: UInt, col: UInt) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        numRow = row
        numCol = col
        containButtons.append(contentsOf: withButtons)
        for v in containButtons {
            self.addSubview(v)
        }
    }
    
    override func layoutSubviews() {
        let btnWidth = (self.frame.size.width - CGFloat(numCol + 1) * horizontalPadding) / CGFloat(numCol)
        let btnHeight = (self.frame.size.height - CGFloat(numRow + 1) * verticalPadding) / CGFloat(numRow)
        
        var currentx: CGFloat = 0
        var currenty: CGFloat = 0
        var currentcol: UInt = 0
        for v in containButtons {
            let x = horizontalPadding + currentx
            let y = verticalPadding + currenty
            v.frame = CGRect(x: x, y: y, width: btnWidth, height: btnHeight)
            
            currentcol += 1
            if currentcol == numCol {
                currentx = 0
                currenty = v.frame.maxY //increase row
            }else {
                currentx = v.frame.maxX
            }
        }
    }
}
