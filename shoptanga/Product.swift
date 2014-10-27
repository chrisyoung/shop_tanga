//
//  product.swift
//  shoptanga
//
//  Created by Chris Young on 10/26/14.
//  Copyright (c) 2014 Chris Young. All rights reserved.
//

import Foundation

class Product {
    var name: NSString = ""
    var description: NSString = ""
    var images = [NSData]()
    var image: NSData = NSData()
    var subtitle: NSString = ""
    var normalPrice: Double = Double()
    var vipPrice: Double = Double()
    var stuPrice: Double = Double()
    var msrp: Double = Double()
    
    
    init(json: NSDictionary){
        self.name = json["name"] as NSString
        self.description = json["description"] as NSString
        self.subtitle = json["subtitle"] as NSString
        setImages(json["images"] as NSArray)
        setPrices(json["prices"] as NSDictionary)
    }
    
    func setPrices(prices: NSDictionary) {
        self.normalPrice = prices["normal_price"] as Double
        self.vipPrice = prices["vip_price"] as Double
        self.stuPrice = prices["stu_price"] as Double
        self.msrp = prices["msrp"] as Double
    }
    
    func setImages(images: NSArray) {
        for var index = 0; index < images.count; ++index {
            var image = images[index] as NSDictionary
            var imgURL: NSURL = NSURL(string: image["url"] as NSString)!
            self.images.append(NSData(contentsOfURL: imgURL)!)
        }
        self.image = self.images[0]
    }

    
    class func buildFromJSON(networkData: NSData) -> NSArray {
        var json = JSON(data: networkData).object as NSArray
        var products = [Product]()
        
        for var index = 0; index < json.count; ++index {
            var productJSON = json[index] as NSDictionary
            products.append(Product(json: productJSON))
        }
        
        return products
    }
}
