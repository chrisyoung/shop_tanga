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
    var images: NSArray = [NSData]()
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
        self.images = getImages(json["images"] as NSArray)
        setPrices(json["prices"] as NSDictionary)
    }
    
    func setPrices(prices: NSDictionary) {
        self.normalPrice = prices["normal_price"] as Double
        self.vipPrice = prices["vip_price"] as Double
        self.stuPrice = prices["stu_price"] as Double
        self.msrp = prices["msrp"] as Double
    }
    
    func getImages(images: NSArray) -> NSArray{
        var result = [NSData]()
        for var index = 0; index < images.count; ++index {
            var image = images[index] as NSDictionary
            var imgURL: NSURL = NSURL(string: image["url"] as NSString)!
            result.append(NSData(contentsOfURL: imgURL)!)
        }
        self.image = result[0]
        return result
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
