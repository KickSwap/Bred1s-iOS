//
//  Notification.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 3/21/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class Notification: NSObject {
    var owner:User?
    var ownerId:String?
    var message: String?
    
    init(data:NSDictionary) {
        self.ownerId = data["ownerId"] as! String?
        self.message = data["message"] as! String?
    }
}