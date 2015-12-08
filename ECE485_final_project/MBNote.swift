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
    var type : String!
    
    required init(noteLetter : String, octave : String, type : String){
        self.noteLetter = noteLetter
        self.octave = octave
        self.duration = 1
        self.type = type
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        noteLetter = aDecoder.decodeObjectForKey("noteLetter") as! String
        octave = aDecoder.decodeObjectForKey("octave") as! String
        duration = aDecoder.decodeObjectForKey("duration") as! Int
        type = aDecoder.decodeObjectForKey("type") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(noteLetter, forKey: "noteLetter")
        aCoder.encodeObject(octave, forKey: "octave")
        aCoder.encodeObject(duration, forKey: "duration")
        aCoder.encodeObject(type, forKey: "type")
    }
    
    func toString() -> String{
        return String(format: "%@%@", noteLetter,octave)
    }
    
    func secondDuration() -> Float{
        return Float(duration) * 0.25
    }
}
