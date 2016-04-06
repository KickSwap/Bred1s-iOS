//
//  Bid.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/18/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class Bid: NSObject {
    
    var bidder:User?
    var bidderId: String?
    var bidPrice:Float?
    var offerShoes: [Shoe]?
    
    private(set) var dict: [String:NSObject]
    
    init(user:User, price:Float) {
            bidder = user
            bidderId = bidder?.uid
            bidPrice = price
            dict = [String:NSObject]()
            dict[bidderId!] = price
    }
    
    func setBid(uid:String, price:String) {
        dict[bidderId!] = price;
    }
    
}
