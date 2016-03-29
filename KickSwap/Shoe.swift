//
//  Shoe.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/18/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class Shoe: NSObject {

    var name: String?
    var color: String?
    var brand: String?
    var imageURL: String?
    var imageString: NSString?
    var shoeImage: UIImage?
    
    var condition: String?
    var size: String?
    var originalBox: Bool?
    var receipt: Bool?
    var owner: User?
    var ownerId: String?
    var price: Double?
    var createdAt: NSDate?
    var createdAtString: String?
    
    //var willingToTradeFor: [Shoe]?
    //var bids:[Bids]
    override init() {

    }
    
    init(data:NSDictionary) {
        self.name = data["name"] as? String
        self.brand = data["brand"] as? String
        self.color = data["color"] as? String
        self.imageURL = data["imageURL"] as? String
        
        self.ownerId = data["ownerId"] as? String
        self.condition = data["condition"] as? String
        self.size = data["size"] as? String
        self.originalBox = data["originalBox"] as? Bool
        self.receipt = data["receipt"] as? Bool
        self.imageString = data["imageString"] as? NSString
        self.shoeImage = UIImage()
        //self.owner?.uid = data["ownerId"] as? String
        // make call w/ ownerId
        //self.owner = d
    }
    
    func getShoe() -> [String:String]{
        return ["name": name!,
                "color": "",
                "brand": "",
                "ownerId": ownerId!,
                "condition": condition!,
                "size": size!,
                "originalBox": "",
                "receipt": "",
                "imageString": imageString! as String
        ]
    }
    
    func printShoe(){
        print(name)
        print(price)
        print(brand)
        print(ownerId)
        print(condition)
        print(size)
        print(originalBox)
        print(receipt)
    }
}

