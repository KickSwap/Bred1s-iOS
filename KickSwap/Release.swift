//
//  Release.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 3/16/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import Foundation
class Release:NSObject {
    
    var sneakerName:String?
    var price:String?
    var detailURL:NSURL?
    var releaseDateAsString:String?
    var releaseDate: NSURL?
    var voteCount:Int?
    
    init(name:String, data: NSDictionary) {
        sneakerName = name
        price = data["Price"] as! String
        detailURL = NSURL(string: data["detailURL"] as! String)
        releaseDateAsString = data["releaseDate"] as! String
        let temp = data["voteCount"] as! String
        voteCount = Int(temp)
    }
    
//    override func getShoe() -> [String : String] {
//        
//    }
}