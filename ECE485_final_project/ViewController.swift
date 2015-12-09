//
//  ViewController.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 11/30/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, MatlabLoadDelegate {
    
    let dataModel = MBDataModel.sharedInstance
    
    @IBOutlet weak var matlabInitView: NSView?
    @IBOutlet weak var matlabInitProgressIndicator: NSProgressIndicator?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.matlabLoadDelegate = self;
        matlabInitProgressIndicator?.startAnimation(self)
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func matlabDidLoad() {
        matlabInitView?.hidden = true
        self.dismissViewController(self)
    }

}

