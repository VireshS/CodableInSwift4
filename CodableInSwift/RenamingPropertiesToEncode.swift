//
//  BasicEncodingDecoding.swift
//  CodableInSwift
//
//  Created by Singh, Viresh on 14/03/18.
//  Copyright © 2018 Viresh. All rights reserved.
//

import UIKit

class Book: NSObject, Codable
{
    var name: String        = ""
    var publisher: String   = ""
    var author:String       = ""
    var isReleased:Bool     = false
    var numberOfPages:Int   = 0
    
    enum CodingKeys:String,CodingKey
    {
        //It will replace the respective properties name by assigned string while encoding to Json or pList format.
        //Also, while decoding respective Json or pList, these new names are expected in data rather that that defined in class declaration
        
        //will get renamed
        case name = "bookName"
        //will not get renamed
        case publisher
        //will get renamed
        case author = "writtenBy"
        //will not get renamed
        case isReleased
        //will get renamed
        case numberOfPages = "pagesInTheBook"
        
    }
}

