//
//  MBTrackHeaderView.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/5/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBTrackHeaderView: MBColorableView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        forceFrameSize(NSMakeSize(70, self.frame.height))
        // Drawing code here.
    }
    
    override func setFrameSize(newSize: NSSize) {
        //constant frame width
        super.setFrameSize(NSMakeSize(70, newSize.height))
    }
    
    func forceFrameSize(newSize: NSSize) {
        super.setFrameSize(newSize)
    }
    
}
