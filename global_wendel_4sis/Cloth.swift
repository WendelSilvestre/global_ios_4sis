//
//  cloth.swift
//  global_wendel_4sis
//
//  Created by Wendel Silvestre on 28/05/26.
//

import Foundation

class Cloth {
    var clothTemperature:Float!
    var mode:String!
    var adaptiveMeasures:Array<String>!
    
    init(){}
    
    init(clothTemperature:Float, mode:String, adaptiveMeasures:Array<String>){
        self.clothTemperature = clothTemperature
        self.mode = Cloth.validateMode(mode)
        self.adaptiveMeasures = adaptiveMeasures
    }
    
    static func validateMode(_ mode:String)->String{
        let validModes = ["cold", "hot", "warm"]

        if validModes.contains(mode.lowercased()) {
            return mode
        }

        return "basic"
    }
}
