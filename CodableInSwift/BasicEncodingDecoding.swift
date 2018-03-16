//
//  BasicEncodingDecoding.swift
//  CodableInSwift
//
//  Created by Singh, Viresh on 14/03/18.
//  Copyright © 2018 Viresh. All rights reserved.
//

import UIKit

struct CarSize:Codable
{
    var height: Double
    var length: Double
}

enum CarType: String, Codable
{
    case Unknown
    case SUV
    case Sedan
    case Hatchback
    case Racing
}
class MyClass: NSObject, Codable
{
    var myVar:String = ""
    var myArray:[String] = [String]()
    var otherDetails:[String:String] = [String:String]()
    var childObjects:[MyClass] = [MyClass]()
    
}
class Car: NSObject, Codable
{
    //String, URL, Bool and Date conform to Codable.
    var name: String = ""
    var companyURL: URL? = nil
    var yearOfManufacture: Int = 0
    var isNew:Bool = true
    
    //The Dictionary is of type [String:String] and String already conforms to Codable.
    var otherDetailsData: [String:String]? = nil
    
    //carType and Size are also Codable types
    var carType: CarType = .Unknown
    var carSize: CarSize = CarSize(height: 0, length: 0)    
}

