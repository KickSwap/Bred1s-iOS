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
    var loginCompletion: ((user:User?, error:NSError?) -> ())?
    
    private class myURIs{
        //auth related calls
        static let users = "users"
    }
    
    static func getRef() -> AnyObject {
        return Firebase(url: baseURL)
    }
    
    static func getUserRef() -> AnyObject {
        return Firebase(url: "\(baseURL)/\(myURIs.users)")
    }
    
    static func getRefWith(child:String) -> AnyObject {
        return Firebase(url: "\(baseURL)/\(child)")
    }
    
    
    
    /* Login w/ Facebook
        - Register user into Firebase DB with FacebookID
    */
    
    static func loginWithFacebook(fbAccessToken:String, handler:FirebaseLoginHandler?) {
        //connect controllers handler to self.handler
        myHandler = handler
        
        //Check if User Already Exist >> login

        //Authenticate with facebookID
        getRef().authWithOAuthProvider("facebook", token: fbAccessToken,
            withCompletionBlock: { error, authData in
                if error != nil {
                    print("Login failed. \(error)")
                } else {
                    //set global currentUser
                    let newUser = User(data: authData)
                    User.currentUser = newUser
                    
                    //set value back into Firebase
                    saveUser(User.currentUser!)
                    myHandler?.loginCompletion()
            }
        })
    }
    
    func loginWithCompletion(completion: (user:User?, error:NSError?) -> ()){
        loginCompletion = completion
    }
    
    static func saveUser(user: User){
        //set User information into firebase
        getUserRef().childByAppendingPath(user.uid).setValue(user.providerData)
    }
    
    static func checkIfUserExist(userToCheck:User) -> Bool {
        //return getUserRef().childSnapshotForPath("/\(userToCheck.uid)").exists()
        return true
    }
    
}
