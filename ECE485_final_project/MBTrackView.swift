//
//  MBTrackView.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/4/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBTrackView: NSView {
    
    @IBOutlet var view : NSView?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        NSBundle.mainBundle().loadNibNamed("MBTrackView", owner: self, topLevelObjects: nil)
        
        setContentFrame()
        
        self.addSubview(self.view!)
    }
    
    override func setFrameSize(newSize: NSSize) {
        super.setFrameSize(newSize)
        setContentFrame()
    }
    
    func setContentFrame(){
        let contentFrame = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height)
        self.view!.frame = contentFrame
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
