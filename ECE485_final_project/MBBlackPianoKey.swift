//
//  MBBlackPianoKey.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/8/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

@objc protocol MBBlackPianoKeyMouseDelegate {
    func mouseClickedBlackKey(sender:MBBlackPianoKey)
}

class MBBlackPianoKey: MBColorableView {
    
    var note : String?
    var secondNote : String?
    @IBOutlet var delegate : AnyObject?

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        let keyLabel = NSTextField(frame: NSRect(x: 0, y: 0, width: 20, height: 16))
        keyLabel.font = NSFont.systemFontOfSize(11)
        keyLabel.textColor = NSColor.whiteColor()
        keyLabel.selectable = false
        keyLabel.editable = false
        keyLabel.bordered = false
        keyLabel.backgroundColor = NSColor.clearColor()
        keyLabel.stringValue = note!
        self.addSubview(keyLabel)
        
        let secondaryKeyLabel = NSTextField(frame: NSRect(x: 0, y: 16, width: 20, height: 16))
        secondaryKeyLabel.font = NSFont.systemFontOfSize(11)
        secondaryKeyLabel.textColor = NSColor.whiteColor()
        secondaryKeyLabel.selectable = false
        secondaryKeyLabel.editable = false
        secondaryKeyLabel.bordered = false
        secondaryKeyLabel.backgroundColor = NSColor.clearColor()
        secondaryKeyLabel.stringValue = secondNote!
        self.addSubview(secondaryKeyLabel)
    }
    
    //this should be subclassed, but am lazy
    override func mouseEntered(theEvent: NSEvent) {
        self.color = NSColor.grayColor()
        self.draw()
    }
    
    override func mouseExited(theEvent: NSEvent) {
        self.color = NSColor.blackColor()
        self.draw()
    }
    
    override func mouseUp(theEvent: NSEvent) {
        delegate?.mouseClickedBlackKey(self)
    }
    
    override func updateTrackingAreas() {
        let trackingArea = NSTrackingArea(rect: self.bounds, options: [NSTrackingAreaOptions.ActiveAlways, NSTrackingAreaOptions.MouseEnteredAndExited], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
}
