//
//  MBBackgroundView.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/8/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBBackgroundView: MBColorableView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        self.layer?.opacity = 0.15
        // Drawing code here.
    }
    
}
