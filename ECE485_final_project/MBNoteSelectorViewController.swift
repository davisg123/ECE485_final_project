//
//  MBNoteSelectorViewController.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/3/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBNoteSelectorViewController: NSViewController,MBPianoKeyMouseDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
    }
    
    func mouseClickedKey(sender:MBPianoKey) {
        print("clicked ")
        print(sender.note)
    }
    
}
