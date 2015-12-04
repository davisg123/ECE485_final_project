//
//  MBCentralViewController.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/3/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBCentralViewController: NSViewController, MatlabEventDelegate {
    
    let dataModel = MBDataModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.matlabEventDelegate = self;
        // Do view setup here.
    }
    
    func matlabDidOutput(output: String) {
        print(output)
    }
    
    func matlabDidEncounterError(error: String) {
        print("Error!")
        print(error)
    }

    
}
