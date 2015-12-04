//
//  MBColorableView.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/3/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBColorableView: NSView {
    
    var color : NSColor?


    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        self.draw()
        // Drawing code here.
    }
    
    func draw(){
        self.wantsLayer = true
        self.layer?.backgroundColor = color!.CGColor
    }
    
}
