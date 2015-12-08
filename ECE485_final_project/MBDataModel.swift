//
//  MBDataModel.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 11/30/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Foundation

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
    let MATLAB_PATH = "/Applications/MATLAB_R2015b.app/bin/matlab";
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
        issueCommand("soundsc(a,8000);\n")
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