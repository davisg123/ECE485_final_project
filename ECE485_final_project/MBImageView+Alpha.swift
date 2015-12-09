//
//  MBImageView+Alpha.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/8/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBImageView_Alpha: NSImageView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
        self.layer?.opacity = 0.1
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        // Drawing code here.
    }
    
}
