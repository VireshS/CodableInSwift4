//
//  BasicEncodingDecoding.swift
//  CodableInSwift
//
//  Created by Singh, Viresh on 14/03/18.
//  Copyright © 2018 Viresh. All rights reserved.
//

import UIKit

class Aisle: NSObject, Codable
{
    var name:String = ""
    var shelves:[Shelf] = [Shelf]()
}

class Shelf: NSObject, Codable
{
    var name:String = ""
    var products:[Product] = [Product]()
}

class Product: NSObject, Codable
{
    var name:String = ""
    var points:Int = 0
    var productDescription: String = ""
    var price:Double = 0.0
}

class Supermarket: NSObject, Codable
{
    var name: String    = ""
    var address:String  = ""
    var phone:String    = ""
    var aisles:[Aisle]  = [Aisle]()
}


class SupermarketData: NSObject, Codable
{
    var name: String    = ""
    var address:String  = ""
    var phone:String    = ""
    var products:[Product]  = [Product]()
    
    init(from rawSupermarket:Supermarket)
    {
        self.name = rawSupermarket.name
        self.address = rawSupermarket.address
        self.phone = rawSupermarket.phone
        for aisle in rawSupermarket.aisles
        {
            for shelf in aisle.shelves
            {
                self.products.append(contentsOf: shelf.products)
            }
        }
    }

}



