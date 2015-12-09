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
    
    //colors defined in IB (file's owner)
    @IBOutlet var greenColor : NSColor?
    @IBOutlet var orangeColor : NSColor?
    @IBOutlet var redColor : NSColor?
    @IBOutlet var turquoiseColor : NSColor?
    @IBOutlet var asphaltColor : NSColor?
    
    @IBOutlet var noteDur : NSTextField?
    
    var note : MBNote?
    
    var widthLocked : Bool = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    init(frame frameRect: NSRect, note: MBNote) {
        self.note = note
        super.init(frame: frameRect)
        widthLocked = true
        self.performSelector("unlockWidth", withObject: nil, afterDelay: 0.1)
        NSBundle.mainBundle().loadNibNamed("MBNoteView", owner: self, topLevelObjects: nil)
        self.addSubview(self.view!)
        if note.effect == "flanger"{
            self.color = greenColor
        }
        else if note.effect == "wah_wah"{
            self.color = orangeColor
        }
        else if note.effect == "vibrato"{
            self.color = redColor
        }
        else if note.effect == "overdrive"{
            self.color = turquoiseColor
        }
        else if note.effect == "fuzz"{
            self.color = asphaltColor
        }
        
    }
    
    func unlockWidth(){
       widthLocked = false
    }
    
    func sharedInit() {
        NSBundle.mainBundle().loadNibNamed("MBNoteView", owner: self, topLevelObjects: nil)
        
        setContentFrame()
        
        self.addSubview(self.view!)
    }
    
    override func setFrameSize(newSize: NSSize) {
        var size = newSize
        if (widthLocked){
            size.width = self.frame.size.width
        }
        else{
            size.width = newSize.width < 50 ? 50 : newSize.width
        }
        super.setFrameSize(size)
        setContentFrame()
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        updateContent()
    }
    
    override func rightMouseDown(theEvent: NSEvent) {
        self.removeFromSuperview()
    }
    
    
    func updateContent(){
        self.noteView?.stringValue = note!.noteLetter
        self.octaveView?.stringValue = String(format: "Octave %@", note!.octave)
        noteDur?.stringValue = String(format: "%d", note!.duration)
    }
    

    
    func setContentFrame(){
        let widthRounded = 50 * Int(round(self.frame.size.width / 50.0))
        var durVal = Int(widthRounded/50)
        durVal = durVal==0 ? 1 : durVal
        note?.duration = durVal
        noteDur?.stringValue = String(format: "%d", durVal)
        let contentFrame = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height)
        self.view!.frame = contentFrame
    }

    
}
