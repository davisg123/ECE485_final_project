//
//  MBTrackHeaderView.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/5/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

protocol MBTrackHeaderViewClickDelegate {
    func headerViewClicked()
}

class MBTrackHeaderView: MBColorableView {
    
    var clickDelegate : MBTrackHeaderViewClickDelegate?
    
    var unselectedColor : NSColor?
    var selectedColor : NSColor?
    
    var selected : Bool!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selected = false
    }

    override func drawRect(dirtyRect: NSRect) {
        self.color = selected! ? selectedColor : unselectedColor
        super.drawRect(dirtyRect)
        setFrameSize(NSMakeSize(70, self.frame.height))
        // Drawing code here.
    }
    
    func setSelected(selected: Bool) {
        self.color = selected ? selectedColor : unselectedColor
        self.draw()
    }
    
    override func mouseUp(theEvent: NSEvent) {
        clickDelegate!.headerViewClicked()
    }
    
}
