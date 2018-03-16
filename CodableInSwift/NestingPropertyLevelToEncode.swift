//
//  BasicEncodingDecoding.swift
//  CodableInSwift
//
//  Created by Singh, Viresh on 14/03/18.
//  Copyright © 2018 Viresh. All rights reserved.
//

import UIKit

struct PhotoSize:Codable
{
    var height: Double
    var width: Double
}
class Photo: NSObject, Codable
{
    var name: String        = ""
    var url: URL?           = nil
    var size:PhotoSize      = PhotoSize(height: 0, width: 0)
    
    enum CodingKeys:String,CodingKey
    {
        case name 
        case url
        case height
        case width
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
        try container.encode(size.width, forKey: .width)
        try container.encode(size.height, forKey: .height)
    }
    override init() {
        
    }
    convenience required init(from decoder: Decoder) throws
    {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        url = try values.decode(URL.self, forKey: .url)
        let width = try values.decode(Double.self, forKey: .width)
        let height = try values.decode(Double.self, forKey: .height)
        size = PhotoSize(height: height, width: width)
    }
}



