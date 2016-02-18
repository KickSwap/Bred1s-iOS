//
//  Firebase.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/17/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import Firebase

let baseURL = "https://kickswap.firebaseio.com"

protocol FirebaseLoginHandler {
    func loginCompletion() -> Void
    func loginFailure(error: NSError?) -> Void
}

class FirebaseClient {
    
    private static var myHandler : FirebaseLoginHandler?
    
    private class myURIs{
        //auth related calls
        static let users = "users"
    }
    
    private static func getRef() -> AnyObject {
        return Firebase(url: baseURL)
    }
    
    private static func getUserRef() -> AnyObject {
        return Firebase(url: "\(baseURL)/\(myURIs.users)")
    }
    
    private static func getRefWith(child:String) -> AnyObject {
        return Firebase(url: "\(baseURL)/\(child)")
    }
    
    
    
    /* Login w/ Facebook
        - Register user into Firebase DB with FacebookID
    */
    
    static func loginWithFacebook(fbAccessToken : String) {
        //Check if User Already Exist >> login

        //Authenticate with facebookID
        getRef().authWithOAuthProvider("facebook", token: fbAccessToken,
            withCompletionBlock: { error, authData in
                if error != nil {
                    print("Login failed. \(error)")
                } else {
                    //set global currentUser
                    let currentUser = User(data: authData)
                    
                    //set value back into Firebase
                    setUser(currentUser)
                    myHandler?.loginCompletion()
                    
//                    //Does user already Exist
//                    if checkIfUserExist(currentUser) {
//                       //normal login
//                        print("user exist")
//                    
//                    } else {
//                        //create completion to all segue way to initUser
//
//                    }
                }
        })
    }
    
    static func setUser(user: User){
        //set User information into firebase
        getUserRef().childByAppendingPath(user.uid).setValue(user.providerData)
    }
    
    static func checkIfUserExist(userToCheck:User) -> Bool {
        //return getUserRef().childSnapshotForPath("/\(userToCheck.uid)").exists()
        return true
    }
    
}
