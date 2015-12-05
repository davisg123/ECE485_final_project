//
//  MBTrackView.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/4/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBTrackView: NSView, NSSplitViewDelegate {
    
    @IBOutlet var view : NSView?
    @IBOutlet var splitView : NSSplitView?
    var borderColor : NSColor?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        NSBundle.mainBundle().loadNibNamed("MBTrackView", owner: self, topLevelObjects: nil)
        
        setContentFrame()
        
        self.wantsLayer = true
        self.layer?.cornerRadius = 5.0
        
        self.addSubview(self.view!)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        NSBundle.mainBundle().loadNibNamed("MBTrackView", owner: self, topLevelObjects: nil)
        
        setContentFrame()
        
        self.wantsLayer = true
        self.layer?.cornerRadius = 5.0
        
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

        self.layer?.borderColor = borderColor!.CGColor
        self.layer?.borderWidth = 1.0
    }
    
    func splitView(splitView: NSSplitView, shouldAdjustSizeOfSubview view: NSView) -> Bool {
        return true;
    }
    
    func splitView(splitView: NSSplitView, shouldHideDividerAtIndex dividerIndex: Int) -> Bool {
        //hide the divider of the track header view
        return dividerIndex == 0
    }
    
    func splitView(splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        if (dividerIndex == 0){
            return 70;
        }
        return CGFloat.max
    }
    
    func splitView(splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        if (dividerIndex == 0){
            return 70;
        }
        return CGFloat.min
    }
    
}
