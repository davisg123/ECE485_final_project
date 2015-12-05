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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        NSBundle.mainBundle().loadNibNamed("MBNoteView", owner: self, topLevelObjects: nil)
        
        setContentFrame()
        
        self.wantsLayer = true
        self.layer?.cornerRadius = 5.0
        
        self.addSubview(self.view!)
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    func setContentFrame(){
        let contentFrame = NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height)
        self.view!.frame = contentFrame
    }
    
}
