//
//  Person.swift
//  global_wendel_4sis
//
//  Created by Wendel Silvestre on 28/05/26.
//

import Foundation

class Person {
    var name:String!
    var height:Float!
    var measures:Array<String>!
    var bodyTemperature:Float!
    
    init() {}
    
    init(name:String, height:Float, measures:Array<String>, bodyTemperature:Float){
        self.name = name
        self.height = height
        self.measures = measures
        self.bodyTemperature = bodyTemperature
    }
    
    func calculateBodyTemperature(clothTempreature:Float, ambientTemperature:Float)->Float{
        idealTemperature = (clothTempreature * 0.2) + ambientTemperature/3 //Imagina que isso eh uma funcao bem complicada
        return idealTemperature
    }
    
    
}
