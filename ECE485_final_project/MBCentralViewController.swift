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
    
    //MARK: saving
    
    @IBAction func saveFile(sender: NSButton) {
        var noteArrays : [[MBNote]] = []
        for sub in splitTrackView!.subviews{
            let trackView = sub as! MBTrackView
            noteArrays.append(trackView.noteArray())
        }
        let data = NSKeyedArchiver.archivedDataWithRootObject(noteArrays)
        let savePanel = NSSavePanel()
        savePanel.beginWithCompletionHandler { (result: Int) -> Void in
            if result == NSFileHandlingPanelOKButton {
                let exportedFileURL = savePanel.URL
                data.writeToFile(exportedFileURL!.path!, atomically: true)
            }
        }
    }
    
    @IBAction func openFile(sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.beginWithCompletionHandler { (result: Int) -> Void in
            if result == NSFileHandlingPanelOKButton {
                let openURL = openPanel.URL
                let data = NSData(contentsOfURL:openURL!)
                let noteArrays = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [[MBNote]]
                
                while self.splitTrackView!.subviews.count < noteArrays.count {
                    self.addNewTrack(NSButton())
                }
                for i in 0...noteArrays.count - 1 {
                    let noteArray = noteArrays[i]
                    let subview = self.splitTrackView?.subviews[i] as! MBTrackView
                    subview.rebuildWithNotes(noteArray)
                }
            }
        }
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
