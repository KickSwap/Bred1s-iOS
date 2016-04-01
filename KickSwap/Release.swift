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
    var imageURL:NSURL?
    var detailURL:NSURL?
    var releaseDateAsString:String?
    var releaseDate: NSDate?
    var voteCount:Int?
    
    init(name:String, data: NSDictionary) {
        
        sneakerName = name
    
        if data["Price"] != nil {
            price = data["Price"] as? String
        }
        
        if data["detailURL"] != nil {
            detailURL = NSURL(string: data["detailURL"] as! String)
        }
        
        if data["releaseDate"] != nil {
            releaseDateAsString = data["releaseDate"] as? String
        }
        
        if data["voteCount"] != nil {
            let temp = data["voteCount"] as? String
            voteCount = Int(temp!)
        }
        
        if data["imageURL"] != nil {
            imageURL = NSURL(string: data["imageURL"] as! String)
        }
        
    }
    
//    override func getShoe() -> [String : String] {
//        
//    }
}