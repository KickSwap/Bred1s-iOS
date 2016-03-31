//
//  User.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/17/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

let userDidLoginNotification = "userDidLoginNotif"
let userDidLogoutNotification = "userDidLogoutNotif"

class User: NSObject {

    //Core Data
    private static let persistedKeyName = "KickSwap.CURRENT_USER"

    //Firebase FAuth Data
    var displayName: String?
    var profilePicUrl: String?
    var uid: String?
    var provider: String?
    var token: String?
    var auth: NSDictionary?
    var providerData: NSDictionary?
    var authData: FAuthData?
    var authDataAsDictionary: NSDictionary?

    //Facebook Profile Fields

    //User Wants/Detail Fields
    var wishlist: [Shoe]?
    var watching: [Shoe]?

    init(data : FAuthData) {
        self.authData = data // set callback from Firebase to object
        self.authDataAsDictionary = NSDictionary(dictionary: ["uid":data.uid, "provider":data.provider, "token":data.token, "auth":data.auth, "providerData":data.providerData])

        //serialize data >> Object
        self.uid = data.uid
        self.provider = data.provider
        self.token = data.token
        self.auth = data.auth
        self.providerData = data.providerData
    }

    init(dictionary:NSDictionary){
        //self.authData = dictionary["authData"] as? FAuthData
        self.authDataAsDictionary = dictionary
        
        if dictionary["providerData"] == nil {
            self.displayName = dictionary["displayName"] as? String
        } else {
            self.displayName = dictionary["providerData"]!["displayName"] as? String
        }
        
        if dictionary["providerData"] == nil {
            self.profilePicUrl = dictionary["profileImageURL"] as? String
        } else {
            self.profilePicUrl = dictionary["providerData"]!["profileImageURL"] as? String
        }
        
        self.uid = dictionary["id"] as? String
        self.provider = dictionary["provider"] as? String
        self.token = dictionary["token"] as? String
        self.auth = dictionary["auth"] as? NSDictionary
        self.providerData = dictionary["providerData"]as? NSDictionary
    }

    func logout() {
        User.currentUser = nil
        FirebaseClient.getRef().unauth() // for firbase
        FBSDKLoginManager().logOut() // for Facebook
        NSUserDefaults.standardUserDefaults().removeObjectForKey(User.persistedKeyName) // removeKey in CoreData
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    func printUser(){
        print(displayName)
    }

    // MARK: - Current User
    private static var _currentUser : User? = nil
    static var currentUser : User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(User.persistedKeyName) as? NSData
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
                        _currentUser = User(dictionary: dictionary as! NSDictionary)
                    }   catch let error as NSError {
                        //handle error
                        print("Error : \(error)")
                    }
                }
            }

            return _currentUser
        }

        set(user) {
            _currentUser = user
            if _currentUser != nil {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.authDataAsDictionary!, options: NSJSONWritingOptions(rawValue: 0))
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: User.persistedKeyName)
                }   catch let error as NSError {
                        //handle error
                        print("Error : \(error)")
                    }
                }
            }
    }
}
