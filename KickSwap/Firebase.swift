//
//  Firebase.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/17/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import Firebase

protocol FirebaseLoginDelegate: class {
    func loginCompletion() -> Void
    func loginFailure(error: NSError?) -> Void
}

class FirebaseClient: NSObject {
    
    static let sharedClient = FirebaseClient()
    static let baseURL = "https://kickswap.firebaseio.com"

    weak var loginDelegate: FirebaseLoginDelegate?
    
    private class myURIs{
        //auth related calls
        static let users = "users"
        static let shoes = "shoes"
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
    
    func loginWithFacebook(fbAccessToken:String) {
        //Authenticate with facebookID
        FirebaseClient.getRef().authWithOAuthProvider("facebook", token: fbAccessToken,
            withCompletionBlock: { error, authData in
                if error != nil {
                    print("Login failed. \(error)")
                    self.loginDelegate?.loginFailure(error)
                } else {
                    //set global currentUser
                    let newUser = User(data: authData)
                    User.currentUser = newUser
                    
                    //set value back into Firebase
                    FirebaseClient.saveUser(User.currentUser!)
                    self.loginDelegate?.loginCompletion()
            }
        })
    }
    
    static func saveUser(user: User){
        //set User information into firebase
        getUserRef().childByAppendingPath(user.uid).setValue(user.providerData)
    }
    
    static func checkIfUserExist(userToCheck:User) -> Bool {
        //return getUserRef().childSnapshotForPath("/\(userToCheck.uid)").exists()
        return true
    }
    
    //MARK: - KickSwap Methods
    static func saveShoes(shoeToSave: Shoe){
        let shoeRef = getRefWith("shoes").childByAutoId()
        shoeRef.setValue(shoeToSave.getShoe())
        
        //TODO: append key to user locker
        //var shoeId = shoeRef.key
    }
    
    static func getShoes() -> [Shoe] {
        // Get a reference to our posts
        let shoeRef = FirebaseClient.getRefWith("shoes")
        
        var shoeArray = [Shoe]()
        
        //let shoeRef = Firebase.init(url: "https://kickswap.firebaseio.com/shoes")
        
        // Attach a closure to read the data at our posts reference
        shoeRef.observeEventType(.Value, withBlock: { snapshot in
            var tempShoeArray = [Shoe]()
            let dict = snapshot.value as! NSDictionary
            for x in dict {
                var shoeToAppend = Shoe(data: x.value as! NSDictionary)
                if shoeToAppend.imageString != nil {
                    var decodedImageString = NSData(base64EncodedString: shoeToAppend.imageString as! String, options: NSDataBase64DecodingOptions(arrayLiteral: NSDataBase64DecodingOptions.IgnoreUnknownCharacters))
                    var decodedImage = UIImage(data: decodedImageString!)
                    shoeToAppend.shoeImage = decodedImage
                    tempShoeArray.append(shoeToAppend)
                }
            }
            
            shoeArray = tempShoeArray
            
            }, withCancelBlock: { error in
                print(error.description)
        })
     
        return shoeArray
    }

    
}
