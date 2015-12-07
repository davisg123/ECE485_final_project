//
//  MBCentralViewController.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/3/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBCentralViewController: NSViewController, MatlabEventDelegate, NSSplitViewDelegate, MBTrackViewClickDelegate, MBNoteSelectorDelegate {
    
    let NEW_TRACK_WIDTH = 700
    let NEW_TRACK_HEIGHT = 100
    
    let dataModel = MBDataModel.sharedInstance
    @IBOutlet var splitTrackView : NSSplitView?
    @IBOutlet var splitTrackViewHeightConstraint : NSLayoutConstraint?
    @IBOutlet var initialTrackView : MBTrackView?
    
    var trackNumCount = 0
    
    var selectedTrack : MBTrackView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialTrackView?.delegate = self;
        initialTrackView?.trackNumLabel?.stringValue = "Track " + String(trackNumCount++)
        dataModel.matlabEventDelegate = self
        // Do view setup here.
    }
    
    @IBAction func addNewTrack(sender: NSButton) {
        let newTrackView = MBTrackView(frame: NSRect(x: 0, y: 0, width: NEW_TRACK_WIDTH, height: NEW_TRACK_HEIGHT))
        newTrackView.delegate = self
        newTrackView.trackNumLabel?.stringValue = "Track " + String(trackNumCount++)
        splitTrackView?.addArrangedSubview(newTrackView)
        splitTrackViewHeightConstraint?.constant = splitTrackViewHeightConstraint!.constant + 100
        splitTrackView?.adjustSubviews()
    }
    
    //MARK: matlab
    
    func matlabDidOutput(output: String) {
        print(output)
    }
    
    func matlabDidEncounterError(error: String) {
        print("Error!")
        print(error)
    }
    
    //MARK: splitview delegate
    
    func splitView(splitView: NSSplitView, shouldAdjustSizeOfSubview view: NSView) -> Bool {
        return true
    }
    
    //MARK: MBTrackViewClickDelegate
    
    func trackSelected(sender:MBTrackView) {
        selectedTrack?.setSelected(false)
        sender.setSelected(true)
        selectedTrack = sender
    }
    
    //MARK: segue
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationController as! MBNoteSelectorViewController
        destination.delegate = self
    }
    
    //MARK: MBNoteSelectorDelegate
    
    func didSelectNote(note: MBNote) {
        if (selectedTrack != nil){
            selectedTrack?.addNoteBlock(note)
        }
        else{
            initialTrackView?.addNoteBlock(note)
        }
    }
    
    
}
