//
//  BasicEncodingDecoding.swift
//  CodableInSwift
//
//  Created by Singh, Viresh on 14/03/18.
//  Copyright © 2018 Viresh. All rights reserved.
//

import UIKit

enum Gender: String, Codable
{
    case Unknown
    case Male
    case Female
}
class Person: NSObject, Codable
{
    var name: String    = ""
    var age: Int        = 0
    var gender:Gender   = .Unknown
    var phone:String    = ""
    var country:String  = ""
    var email:String    = ""
    
    enum CodingKeys:String,CodingKey
    {
        //Encoding/decoding will only include the properties defined in this enum,
        //rest will be ignored
        case name
        case age
        case gender
    }
}

