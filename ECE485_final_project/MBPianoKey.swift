//
//  MBPianoKey.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/3/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

@objc protocol MBPianoKeyMouseDelegate {
    func mouseClickedKey(sender:MBPianoKey)
}

class MBPianoKey: MBColorableView {
    
    var note : String?
    @IBOutlet var delegate : MBPianoKeyMouseDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        
    }

    override func drawRect(dirtyRect: NSRect) {
        self.color = NSColor.whiteColor()
        super.drawRect(dirtyRect)
        self.layer?.cornerRadius = 5.0
        self.layer?.masksToBounds = true
        
        let keyLabel = NSTextField(frame: NSRect(x: 0, y: 0, width: 16, height: 16))
        keyLabel.selectable = false
        keyLabel.editable = false
        keyLabel.bordered = false
        keyLabel.backgroundColor = NSColor.clearColor()
        keyLabel.stringValue = note!
        self.addSubview(keyLabel)
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        self.color = NSColor.grayColor()
        self.draw()
    }
    
    override func mouseExited(theEvent: NSEvent) {
        self.color = NSColor.whiteColor()
        self.draw()
    }
    
    override func mouseUp(theEvent: NSEvent) {
        delegate?.mouseClickedKey(self)
    }
    
    override func updateTrackingAreas() {
        let trackingArea = NSTrackingArea(rect: self.bounds, options: [NSTrackingAreaOptions.ActiveAlways, NSTrackingAreaOptions.MouseEnteredAndExited], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
}
