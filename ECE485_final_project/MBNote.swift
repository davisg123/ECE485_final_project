//
//  MBNote.swift
//  ECE485_final_project
//
//  Created by Davis Gossage on 12/6/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import Cocoa

class MBNote: NSObject {
    var noteLetter : String!
    var octave : String!
    var duration : Int!
    
    required init(noteLetter : String, octave : String){
        self.noteLetter = noteLetter
        self.octave = octave
        self.duration = 1
        super.init()
    }
    
    func toString() -> String{
        return String(format: "%@%@", noteLetter,octave)
    }
}
