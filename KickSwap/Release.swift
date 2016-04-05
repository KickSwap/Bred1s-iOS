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
    var color:String?

    init(name:String, data: NSDictionary) {
        super.init()

        sneakerName = name
        //price = data["Price"] as! String
        detailURL = NSURL(string: data["detailURL"] as! String)
        releaseDateAsString = data["releaseDate"] as! String
        let temp = data["voteCount"] as! String
        voteCount = Int(temp)

        if data["Price"] != nil {
            price = data["Price"] as? String
        }

        if data["detailURL"] != nil {
            detailURL = NSURL(string: data["detailURL"] as! String)
        }

        if data["releaseDate"] != nil {
            releaseDateAsString = data["releaseDate"] as? String
            //Make releaseDate into NSDate
            releaseDate = stringToNSDate(releaseDateAsString!)
        }

        if data["voteCount"] != nil {
            let temp = data["voteCount"] as? String
            voteCount = Int(temp!)
        }

        if data["imageURL"] != nil {
            imageURL = NSURL(string: data["imageURL"] as! String)
        }

        if data["color"] != nil {
            color = data["color"] as! String
        }

    }

    func stringToNSDate(date:String) -> NSDate {
        let strDate = date // "2015-10-06T15:42:34Z"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.dateFromString(strDate)!
    }

}
