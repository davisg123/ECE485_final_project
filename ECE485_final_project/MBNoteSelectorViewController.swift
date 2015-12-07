//
//  MBNoteSelectorViewController.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/3/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

@objc protocol MBNoteSelectorDelegate {
    func didSelectNote(note:MBNote)
}

class MBNoteSelectorViewController: NSViewController,MBPianoKeyMouseDelegate {
    
    @IBOutlet var delegate : MBNoteSelectorDelegate?
    
    @IBOutlet var octaveSelector : NSPopUpButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        octaveSelector.removeAllItems()
        octaveSelector.addItemsWithTitles(["Octave 2","Octave 3","Octave 4","Octave 5","Octave 6","Octave 7","Octave 8"])
        octaveSelector.selectItemAtIndex(1)
        // Do view setup here.
    }
    
    func mouseClickedKey(sender:MBPianoKey) {
        let octaveChar = octaveSelector.titleOfSelectedItem?.characters.last
        let note = MBNote(noteLetter: sender.note!, octave: String(octaveChar!))
        delegate?.didSelectNote(note)
        self.dismissViewController(self)
    }
    
}
