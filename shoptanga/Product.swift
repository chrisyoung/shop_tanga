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
        
    init(json: NSDictionary){
        self.name = json["name"] as NSString
        self.description = json["description"] as NSString
        var images = json["images"] as NSArray
        self.images = getImages(images)
    }
    
    func getImages(images: NSArray) -> NSArray{
        var result = [NSData]()
        for var index = 0; index < 1; ++index {
//        for var index = 0; index < images.count; ++index {
            var image = images[index] as NSDictionary
            var imgURL: NSURL = NSURL(string: image["url"] as NSString)!
            result.append(NSData(contentsOfURL: imgURL)!)
        }
        return result
    }

    
    class func buildFromJSON(networkData: NSData) -> NSArray {
        var json = JSON(data: networkData).object as NSArray
        var products = [Product]()
        
//        for var index = 0; index < json.count; ++index {
        for var index = 0; index < 1; ++index {
            var productJSON = json[index] as NSDictionary
            products.append(Product(json: productJSON))
        }
        
        return products
    }
}
