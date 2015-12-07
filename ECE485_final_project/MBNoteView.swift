//
//  MBNoteView.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/5/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBNoteView: MBColorableView {
    
    @IBOutlet var view : NSView?
    @IBOutlet var noteView : NSTextField?
    @IBOutlet var octaveView : NSTextField?
    
    @IBOutlet var noteDur : NSTextField?
    
    var note : MBNote?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    init(frame frameRect: NSRect, note: MBNote) {
        self.note = note
        super.init(frame: frameRect)
        sharedInit()
    }
    
    func sharedInit() {
        NSBundle.mainBundle().loadNibNamed("MBNoteView", owner: self, topLevelObjects: nil)
        
        setContentFrame()
        
        self.addSubview(self.view!)
    }
    
    override func setFrameSize(newSize: NSSize) {
        //setLockingContentFrame(newSize)
        setContentFrame()
        super.setFrameSize(newSize)
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        self.noteView?.stringValue = note!.noteLetter
        self.octaveView?.stringValue = String(format: "Octave %@", note!.octave)
    }
    
    func setContentFrame(){
        let durVal = Int(floor(self.frame.size.width / 25))
        noteDur?.stringValue = String(format: "%d", durVal)
        let contentFrame = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height)
        self.view!.frame = contentFrame
    }
    
}
