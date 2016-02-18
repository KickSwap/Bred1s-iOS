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
    
    //Core Data
    private static let persistedKeyName = "KickSwap.CURRENT_USER"
    
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
    
    
    
    // MARK: - Current User
    // TODO: error handling
    private static var _currentUser : User? = nil
    static var currentUser : User? {
        get {
        if _currentUser == nil {
            // check if persisted data available
            if let data = NSUserDefaults.standardUserDefaults().objectForKey(User.persistedKeyName) as? NSDictionary {
                    //_currentUser = User(data: data)
                    //_currentUser!.dictionary = JSON(data: data)
                    print("recovered current user \(_currentUser!.uid)")
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            if let user = user {
                // persist current user
                if let data = try? user.authData! as NSDictionary {
                    //convert FauthData to NSDictionary
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: User.persistedKeyName)
                }
            } else {
                // clear current user
                NSUserDefaults.standardUserDefaults().removeObjectForKey(User.persistedKeyName)
            }
            
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func logout() {
        User.currentUser = nil
        
      // NSNotificationCenter.defaultCenter().postNotificationName(Constants.Notifications.userDidLogoutNotification, object: nil)
    }

}
