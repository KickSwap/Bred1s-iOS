//
//  User.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/17/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Firebase

class User: NSObject {
    
    //Firebase FAuth Data
    var uid: String?
    var provider: String?
    var token: String?
    var auth: NSDictionary?
    var providerData: NSDictionary?
    var authData: FAuthData?
    
    //Facebook Profile Fields
    
    
    
    init(data : FAuthData) {
        self.authData = data // set callback from Firebase to object
        
        //serialize data >> Object
        self.uid = data.uid
        self.provider = data.provider
        self.token = data.token
        self.auth = data.auth
        self.providerData = data.providerData
    }
    
}
