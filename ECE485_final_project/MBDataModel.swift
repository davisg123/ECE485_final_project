//
//  MBDataModel.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 11/30/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Foundation

protocol MatlabEventDelegate{
    func matlabDidLoad()
    func matlabDidOutput(output:String)
}

class MBDataModel : NSObject {
    var matlabDelegate:MatlabEventDelegate?
    
    //TODO: search for matlab installation instead of static location
    let MATLAB_PATH = "/Applications/MATLAB_R2015b.app/bin/matlab";
    let MATLAB_PARAMS = "-nodesktop";
    let READY_PROMPT = ">> "
    
    var ready = false;
    var capturedOutput: [String] = []
    
    static let sharedInstance = MBDataModel()
    
    let task = NSTask()
    var taskInput: NSFileHandle?
    let inputPipe = NSPipe()
    var taskOutput: NSFileHandle?
    var outputPipe = NSPipe()
    
    override init(){
        super.init()
        task.launchPath = MATLAB_PATH
        task.arguments = [MATLAB_PARAMS]
        task.standardInput = inputPipe
        taskInput = inputPipe.fileHandleForWriting
        task.standardOutput = outputPipe
        taskOutput = outputPipe.fileHandleForReading
        beginListeningForOutput()
        task.launch()
    }
    
    func issueCommand(command:String){
        taskInput?.writeData(command.dataUsingEncoding(NSASCIIStringEncoding)!)
    }
    
    func readOutput() -> String?{
        let outputData = taskOutput!.availableData
        let outputString = String(data: outputData, encoding: NSASCIIStringEncoding)
        if (ready){
            captureOutput(outputString!)
        }
        else if(outputString == READY_PROMPT){
            matlabDidLoad()
        }
        return outputString
    }
    
    func lastOutput() -> String?{
        return capturedOutput.last
    }
    
    func captureOutput(output:String) {
        matlabDelegate?.matlabDidOutput(output)
        capturedOutput.append(output)
    }
    
    func matlabDidLoad() {
        ready = true
        matlabDelegate?.matlabDidLoad()
    }
    
    //MARK: listeners
    func beginListeningForOutput(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "outputReceived:", name: NSFileHandleDataAvailableNotification, object: taskOutput)
        registerListener()
    }
    
    func registerListener(){
        taskOutput?.waitForDataInBackgroundAndNotify()
    }
    
    func outputReceived(notification:NSNotification){
        readOutput()
        registerListener()
    }
}