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
    
    var condition: String?
    var size: Double?
    var originalBox: Bool?
    var reciept: Bool?
    var owner: User?
    var price: Double?
    var createdAt: NSDate?
    var createdAtString: String?
    
    //var willingToTradeFor: [Shoe]?
    //var bids:[Bids]
}
