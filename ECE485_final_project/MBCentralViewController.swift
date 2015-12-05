//
//  MBCentralViewController.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/3/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBCentralViewController: NSViewController, MatlabEventDelegate, NSSplitViewDelegate {
    
    let NEW_TRACK_WIDTH = 700
    let NEW_TRACK_HEIGHT = 100
    
    let dataModel = MBDataModel.sharedInstance
    @IBOutlet var splitTrackView : NSSplitView?
    @IBOutlet var splitTrackViewHeightConstraint : NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.matlabEventDelegate = self
        // Do view setup here.
    }
    
    @IBAction func addNewTrack(sender: NSButton) {
        let newTrackView = MBTrackView(frame: NSRect(x: 0, y: 0, width: NEW_TRACK_WIDTH, height: NEW_TRACK_HEIGHT))
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
    
}
