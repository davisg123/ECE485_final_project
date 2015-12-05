//
//  MBTrackHeaderView.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/5/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBTrackHeaderView: MBColorableView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        setFrameSize(NSMakeSize(70, self.frame.height))
        // Drawing code here.
    }
    
}
