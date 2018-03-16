//
//  ViewController.swift
//  CodableInSwift
//
//  Created by Singh, Viresh on 13/03/18.
//  Copyright © 2018 Viresh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //lets start with basic encoding/decoding
        self.basicEncoding()
        self.basicDecoding()
        
        //Now we will try to skip few properties while decoding/encoding
        self.EncodingBySkippingProperties()
        self.DecodingBySkippingProperties()
        
        //Lets play more, we will now hide the class property name and rename them to something else while encoding/decoding
        self.EncodingByRenamingProperties()
        self.DecodingByRenamingProperties()
        
        //Handle multiple level of Nested properties or objects
        self.NestedPropertiesEncoding()
        self.NestedPropertiesDecoding()
        
        //Merge multiple level of custom object in JSON or class model whicle encoding/decoding
        self.DecodingByChangingNestingLevelOfProperties()
        self.DecodingByChangingNestingLevelOfProperties()
        
        //Merge the multiple Nesting levels
        self.EncodingByChangingNestingLevelOfProperties()
        self.DecodingByChangingNestingLevelOfProperties()
        
    }
    
    func basicEncoding()
    {
        //Basic Encoding and Decoding
        let carObj = Car()
        carObj.name = "City ZX"
        carObj.isNew = true
        carObj.yearOfManufacture = 2018
        carObj.companyURL = URL(string: "www.honda.com")
        carObj.carType = .Sedan
        carObj.otherDetailsData = ["color":"Red","fuelType":"Petrol"]
        carObj.carSize = CarSize(height: 100, length: 200)
        
        //Encode to Json format
        let encodedObject = try? JSONEncoder().encode(carObj)
        //Encode to plist format
        //let plistObject1 = try? PropertyListEncoder().encode(carObj)
        if let encodedObjectJsonString = String(data: encodedObject!, encoding: .utf8)
        {
            print(encodedObjectJsonString)
        }
        print("End of the Story...")
        print("The End")
    }

    func basicDecoding() {
        let jsonString = """
                        {
                            "name":"City ZX",
                            "isNew":true,
                            "yearOfManufacture":2018,
                            "companyURL":"www.honda.com",
                            "carType":"Sedan",
                            "carSize":{
                                       "height":200,
                                       "height":100
                                   },
                            "otherDetailsData":{
                                       "color":"Red",
                                       "fuelType":"Petrol"
                                   },
                        }
                        """
        if let jsonData = jsonString.data(using: .utf8)
        {
            //And here you get the Car object back
            let carObject = try? JSONDecoder().decode(Car.self, from: jsonData)
        }
    }
    
    
    
    
    func EncodingBySkippingProperties() {
        let personObj = Person()
        personObj.name = "Singh, Viresh"
        personObj.age = 30
        personObj.gender = .Male
        personObj.phone = "9999999999"
        personObj.country = "India"
        personObj.email = "viresh.singh@live.com"
        let encodedObject = try? JSONEncoder().encode(personObj)
        if let encodedObjectJsonString = String(data: encodedObject!, encoding: .utf8)
        {
            //It will encode only selected properties - name, age, gender as we have defined CodingKeys enum in Person class. For more info, check the definition of Person class
            print(encodedObjectJsonString)
        }
        return
    }
    
    func DecodingBySkippingProperties() {
        let jsonString = """
                        {
                            "name":"Singh, Viresh",
                            "age":30,
                            "gender":"Male",
                            "phone":"9999999999",
                            "country":"India",
                            "email":"viresh.singh@live.com"
                        }
                        """
        if let jsonData = jsonString.data(using: .utf8)
        {
            //And here you get the Car object back
            let personObject = try? JSONDecoder().decode(Person.self, from: jsonData)
            //But only with name, age, gender properties decode from json as we have defined CodingKeys enum in Person class. For more info, check the definition of Person class
            print(personObject?.country)
        }
    }
    
    
    func EncodingByRenamingProperties() {
        let bookObj = Book()
        bookObj.name = "The brief history of time"
        bookObj.publisher = "Transworld Digital"
        bookObj.author = "Stephen Hawking"
        bookObj.isReleased = true
        bookObj.numberOfPages = 226
        let encodedObject = try? JSONEncoder().encode(bookObj)
        if let encodedObjectJsonString = String(data: encodedObject!, encoding: .utf8)
        {
            //It will rename the properties in json as follows because we have defined CodingKeys enum in Book class to do so. For more info, check the definition of Book class
            //name -> bookName
            //author -> writtenBy
            //numberOfPages ->pagesInTheBook
            print(encodedObjectJsonString)
        }
        return
    }
    
    func DecodingByRenamingProperties() {
        let jsonString = """
                        {
                            "bookName":"The brief history of time",
                            "publisher":"Transworld Digital",
                            "writtenBy":"Stephen Hawking",
                            "isReleased":true,
                            "pagesInTheBook":226
                        }
                        """
        if let jsonData = jsonString.data(using: .utf8)
        {
            //And here you get the Car object back
            if let bookObject = try? JSONDecoder().decode(Book.self, from: jsonData)
            //It will automatically map the json keys to properties name as defined in Book class and respective CodingKeys enum. For more info, check the definition of Book class
            {
                print(bookObject.name)
                print(bookObject.author)
                print(bookObject.publisher)
                print(bookObject.numberOfPages)
                print(bookObject.isReleased)
            }
        }
    }
    
    func NestedPropertiesEncoding()
    {
        //Lets create a product
        let product = Product()
        product.name = "Apple iPad Pro"
        product.points = 100
        product.productDescription = "iPad Gold, 256 GB, 10.5 Inch"
        product.price = 850
        
        //And put it into a shelf
        let shelf = Shelf()
        shelf.name = "Electronics"
        shelf.products.append(product)
        
        //Assigned to particular aisle
        let aisle = Aisle()
        aisle.name = "New Arrivals"
        aisle.shelves.append(shelf)
        
        //In some supermarket
        let superMarket = Supermarket()
        superMarket.name = "Wallmart"
        superMarket.phone = "9999999999"
        superMarket.address = "Melville, NY"
        superMarket.aisles.append(aisle)
        
        let encodedData = try? JSONEncoder().encode(superMarket)
        if let encodedObjectJsonString = String(data: encodedData!, encoding: .utf8)
        {
            print(encodedObjectJsonString)
        }
    }
    
    
    func NestedPropertiesDecoding()
    {
        let jsonString =    """
                            {
                                "phone":"9999999999",
                                "aisles":[
                                {
                                    "name":"New Arrivals",
                                    "shelves":[
                                            {
                                                "name":"Electronics",
                                                "product":[
                                                        {
                                                        "points":100,
                                                        "productDescription":"iPad Gold, 256 GB, 10.5 Inch",
                                                        "name":"Apple iPad Pro",
                                                        "price":850
                                                        },
                                                        {
                                                        "points":100,
                                                        "productDescription":"iPhone 7 Gold, 256 GB",
                                                        "name":"Apple iPhone 7",
                                                        "price":999
                                                        }
                                                            ]
                                            }
                                                ]
                                }
                                    ],
                                "name":"Wallmart",
                                "address":"Melville, NY"
                            }
                            """
        
        if let jsonData = jsonString.data(using: .utf8)
        {
            //And here you get the Supermarket object back
            if let superMarketObject = try? JSONDecoder().decode(Supermarket.self, from: jsonData)
            {
                print(superMarketObject.aisles.count)
                print(superMarketObject.aisles[0].shelves.count)
                print(superMarketObject.aisles[0].shelves[0].products.count)
            }
        }
    }
    
    
    
    func EncodingByChangingNestingLevelOfProperties() {
        let photoObj = Photo()
        photoObj.url = URL(string:"www.someurl.com/someimage.jpg")
        photoObj.size = PhotoSize(height: 100, width: 200)
        photoObj.name = "Some Image"
        let encodedObject = try? JSONEncoder().encode(photoObj)
        if let encodedObjectJsonString = String(data: encodedObject!, encoding: .utf8)
        {
            //Notice the nesting level of Height and width by replacing size
            print(encodedObjectJsonString)
        }
    }
    
    
    func DecodingByChangingNestingLevelOfProperties()
    {
        let jsonString =    """
                            {
                                "phone":"9999999999",
                                "aisles":[
                                {
                                    "name":"New Arrivals",
                                    "shelves":[
                                            {
                                                "name":"Electronics",
                                                "product":[
                                                        {
                                                        "points":100,
                                                        "productDescription":"iPad Gold, 256 GB, 10.5 Inch",
                                                        "name":"Apple iPad Pro",
                                                        "price":850
                                                        },
                                                        {
                                                        "points":100,
                                                        "productDescription":"iPhone 7 Gold, 256 GB",
                                                        "name":"Apple iPhone 7",
                                                        "price":999
                                                        }
                                                            ]
                                            }
                                                ]
                                }
                                    ],
                                "name":"Wallmart",
                                "address":"Melville, NY"
                            }
                            """
        
        if let jsonData = jsonString.data(using: .utf8)
        {
            //And here you get the Supermarket object back
            if let superMarketObject = try? JSONDecoder().decode(Supermarket.self, from: jsonData)
            {
                print(superMarketObject.aisles.count)
                print(superMarketObject.aisles[0].shelves.count)
                print(superMarketObject.aisles[0].shelves[0].products.count)
                
                //And here we use our 'SupermarketData' calss to have trimmed data of 'Supermarket' class
                let trimmedSupermarket = SupermarketData(from: superMarketObject)
                print(trimmedSupermarket.products.count)
            }
        }
    }
    
    
}

