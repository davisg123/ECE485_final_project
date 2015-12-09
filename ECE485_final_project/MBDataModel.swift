//
//  MBDataModel.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 11/30/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Foundation
import Cocoa

protocol MatlabLoadDelegate{
    func matlabDidLoad()
}

protocol MatlabEventDelegate{
    func matlabDidOutput(output:String)
    func matlabDidEncounterError(error:String)
}

class MBDataModel : NSObject {
    var matlabEventDelegate:MatlabEventDelegate?
    var matlabLoadDelegate:MatlabLoadDelegate?
    
    //TODO: search for matlab installation instead of static location
    var MATLAB_PATH = "/Applications/MATLAB_R2015a.app/bin/matlab";
    let MATLAB_PARAMS = "-nodesktop";
    let READY_PROMPT = ">> "
    let MATLAB_FUNCTION_FOLDER = "Matlab Functions"
    
    var ready = false;
    var capturedOutput: [String] = []
    
    static let sharedInstance = MBDataModel()
    
    let task = NSTask()
    var taskInput: NSFileHandle?
    let inputPipe = NSPipe()
    var taskOutput: NSFileHandle?
    var outputPipe = NSPipe()
    var errorOutput: NSFileHandle?
    var errorPipe = NSPipe()
    
    override init(){
        super.init()
        if NSFileManager.defaultManager().fileExistsAtPath(MATLAB_PATH){
            executeTask()
        }
        else{
            self.performSelector("delayedPrompt", withObject: nil, afterDelay: 0.5)
        }
    }
    
    func delayedPrompt(){
        let openPanel = NSOpenPanel()
        openPanel.directoryURL = NSURL.fileURLWithPath("/Applications")
        openPanel.message = "Please locate your MATLAB installation"
        openPanel.beginWithCompletionHandler { (result: Int) -> Void in
            if result == NSFileHandlingPanelOKButton {
                let openURL = openPanel.URL
                self.MATLAB_PATH = openURL!.path!.stringByAppendingString("/bin/matlab")
                self.executeTask()
            }
        }
    }
    
    func executeTask(){
        task.launchPath = MATLAB_PATH
        task.arguments = [MATLAB_PARAMS]
        task.standardInput = inputPipe
        taskInput = inputPipe.fileHandleForWriting
        task.standardOutput = outputPipe
        task.standardError = errorPipe
        taskOutput = outputPipe.fileHandleForReading
        errorOutput = errorPipe.fileHandleForReading
        beginListeningForOutput()
        task.launch()
    }
    
    //MARK: Output processing
    
    /**
     Read the data currently available from the output pipe
     
     - returns: Available output
    */
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
        matlabEventDelegate?.matlabDidOutput(output)
        capturedOutput.append(output)
    }
    
    func matlabDidLoad() {
        ready = true
        setMatlabDirectory()
        matlabLoadDelegate?.matlabDidLoad()
    }
    
    //MARK: command interface
    
    /**
    Send a command to matlab for processing
    
    - parameter command: Command to process
    */
    func issueCommand(command:String){
        taskInput?.writeData(command.dataUsingEncoding(NSASCIIStringEncoding)!)
    }
    
    //MARK: directory operations
    
    func setMatlabDirectory(){
        let path = NSBundle.mainBundle().pathForResource(MATLAB_FUNCTION_FOLDER, ofType: nil)
        
        issueCommand(String(format: "cd('%@')\n", arguments: [path!]))
    }
    
    //MARK: playing
    
    func playNoteMultiTrackArray(allNotes : [[MBNote]]){
        //only supports two right now 🙁
        var pass = 1
        for notes : [MBNote] in allNotes {
            var output : String = String(format:"a%d = [", pass)
            for note : MBNote in notes {
                output.appendContentsOf(makeWaveFunc(note))
                if (notes.last != note){
                    output.appendContentsOf(",")
                }
            }
            output.appendContentsOf("];\n")
            issueCommand(output)
            pass++
        }
        //here lies the issue 🙁
        issueCommand("c=add_mismatch(a1,a2);\n")
        issueCommand("b = audioplayer(c,8000); play(b);\n")
    }
    
    func playNoteArray(notes : [MBNote]){
        //[dtfs_wave(F,L,Fs,W),...]
        var output : String = "a = ["
        for note : MBNote in notes {
            output.appendContentsOf(makeWaveFunc(note))
            if (notes.last != note){
                output.appendContentsOf(",")
            }
        }
        output.appendContentsOf("];\n")
        issueCommand(output)
        issueCommand("b = audioplayer(a,8000); play(b);\n")
    }
    
    func makeWaveFunc(note : MBNote) -> String{
        if (note.type == "flute"){
            return makeAdsrWaveFunc(note)
        }
        else{
            return makeDtfsWaveFunc(note)
        }
    }
    
    func makeDtfsWaveFunc(note : MBNote) -> String{
        //dtfs_wave(F,L,Fs,W)
        return String(format: "dtfs_wave(%@,%f,%d,'%@')", makeNoteFreqFunc(note),note.secondDuration(),8000,note.type)
    }
    
    func makeAdsrWaveFunc(note : MBNote) -> String{
        //adsr_wave(F,L,Fs)
        return String(format: "adsr_wave(%@,%f,%d)", makeNoteFreqFunc(note),note.secondDuration(),8000)
    }
    
    func makeNoteFreqFunc(note : MBNote) -> String{
        return String(format: "noteFreq('%@')", note.toString())
    }
    
    //MARK: listeners
    
    /**
    Begins listening to the file handler for new data
    */
    func beginListeningForOutput(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "outputReceived:", name: NSFileHandleDataAvailableNotification, object: taskOutput)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "errorReceived:", name: NSFileHandleDataAvailableNotification, object: errorOutput)
        registerListener()
    }
    
    func registerListener(){
        taskOutput?.waitForDataInBackgroundAndNotify()
        errorOutput?.waitForDataInBackgroundAndNotify()
    }
    
    func outputReceived(notification:NSNotification){
        readOutput()
        registerListener()
    }
    
    func errorReceived(notification:NSNotification){
        let outputData = errorOutput!.availableData
        let outputString = String(data: outputData, encoding: NSASCIIStringEncoding)
        matlabEventDelegate?.matlabDidEncounterError(outputString!)
        registerListener()
    }
}