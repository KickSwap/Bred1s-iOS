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
    var uid:String?

    var condition: String?
    var size: String?
    var originalBox: String?
    var receipt: String?
    var owner: User?
    var ownerId: String?
    var price: String?
    var createdAt: NSDate?
    var createdAtString: String?

    //var willingToTradeFor: [Shoe]?
    var bids:[Double]?

    override init() {

    }

    // changed everything to string **Priority to figure out how to handle data**
    init(data:NSDictionary) {
        self.name = data["name"] as? String
        self.brand = data["brand"] as? String
        self.color = data["color"] as? String
        self.imageURL = data["imageURL"] as? String
        self.uid = data["uid"] as? String
        self.ownerId = data["ownerId"] as? String
        self.condition = data["condition"] as? String
        self.size = data["size"] as? String
        self.price = data["price"] as? String
        self.originalBox = data["originalBox"] as? String
        self.receipt = data["receipt"] as? String
        self.imageString = data["imageString"] as? NSString
        self.bids = [Double]()
        self.shoeImage = UIImage()
    }

    func getShoe() -> [String:AnyObject]{
        return ["name": name!,
                "color": "",
                "brand": "",
                "price": price!,
                "ownerId": ownerId!,
                "condition": condition!,
                "size": size!,
                "originalBox": originalBox!,
                "receipt": receipt!,
                "bids": bids!, //Causing error in current build once we arrange Bids comment back Issues
                "imageString": imageString! as String
        ]
    }
    //f_Bids.exists()
    func getBids() {
        FirebaseClient.sharedClient.getBids(self, completion: { (f_bids, error) in
            if f_bids != nil {
                let myBids = f_bids as! NSDictionary
                for price in myBids {
                    self.bids?.append(price.value as! Double)
                }
            } else {
                print("Error: Shoe.getBids")
            }
        })
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
