  //
//  Firebase.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/17/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import Firebase

class CompletionBlock {
    typealias StringArray = ([String]?, NSError?) -> Void
    typealias KSUser = (User?, NSError?) -> Void
    typealias KSUserArray = ([User]?, NSError?) -> Void
    typealias AnyObjArray = ([AnyObject]?, NSError?) -> Void
    typealias AnyObj = (AnyObject?, NSError?) -> Void
}

class FirebaseClient: NSObject {

    static let sharedClient = FirebaseClient()
    static let baseURL = "https://kickswap.firebaseio.com"

    var array:[AnyObject]?


    private class myURIs{
        //auth related calls
        static let users = "users"
        static let shoes = "shoes"
        static let catalog = "catalog"
        static let bids = "bids"
    }

    private func getRef() -> AnyObject {
        return Firebase(url: FirebaseClient.baseURL)
    }

    private func getUserRef() -> AnyObject {
        return Firebase(url: "\(FirebaseClient.baseURL)/\(myURIs.users)")
    }

    private func getRefWith(child:String) -> AnyObject {
        return Firebase(url: "\(FirebaseClient.baseURL)/\(child)")
    }

    /* Login w/ Facebook
     - Register user into Firebase DB with FacebookID
     */

    func loginWithFacebook(fbAccessToken:String, completion:CompletionBlock.KSUser) {
        //Authenticate with facebookID
        FirebaseClient.sharedClient.getRef().authWithOAuthProvider("facebook", token: fbAccessToken, withCompletionBlock: { error, authData in
                    if error != nil {
                            print("Login failed. \(error)")
                                completion(nil,nil)
                    } else {
                        //set global currentUser
                        let newUser = User(data: authData)
                        User.currentUser = newUser

                        //set value back into Firebase
                        // FirebaseClient.saveUser(User.currentUser!)
                        completion(newUser,nil)
                                                                    }
        })
    }

    func saveUser(user: User){
        //set User information into firebase
        getUserRef().childByAppendingPath(user.uid).setValue(user.providerData)
    }

    func getUsers(completion:CompletionBlock.StringArray) {
        let ref = getUserRef()
        // Get the data on a post that has changed
        ref.observeEventType(.Value, withBlock: { snapshot in

            //TODO: write actual NSError for empty snapshot
            if (snapshot == nil) {
                completion(nil, nil)
                return
            }

            let users = snapshot.value as! [String:NSObject] //get all Users

            var usernames = [String]()

            for key in users.keys {// Parse based upon Keys
                if let profileInfo = users[key] as? [String:NSObject] {
                    let profileName = profileInfo["displayName"] as! String
                    usernames.append(profileName)
                }
            }

            completion(usernames, nil)

        })
    }

    //MARK: - KickSwap Methods
    func saveShoes(shoeToSave: Shoe){
        let shoeRef = getRefWith("shoes").childByAutoId()
        print(shoeToSave.getShoe())
        var dict = shoeToSave.getShoe()
        dict["uid"] = shoeRef.key
        print(dict["uid"])
        shoeRef.updateChildValues(dict)
    }

    func getTimelineShoes(completion:CompletionBlock.AnyObjArray){
        let ref = FirebaseClient.sharedClient.getRefWith("shoes")
        // Attach a closure to read the data at our posts reference
        ref.observeEventType(.Value, withBlock: { snapshot in
            var tempShoeArray = [Shoe]()
            let dict = snapshot.value as! NSDictionary
            for x in dict {
                let shoeToAppend = Shoe(data: x.value as! NSDictionary)
                //print(x.value)
                shoeToAppend.printShoe()
                if(shoeToAppend.imageString != nil) {
                    let decodedImageString = NSData(base64EncodedString: shoeToAppend.imageString as! String, options: NSDataBase64DecodingOptions(arrayLiteral: NSDataBase64DecodingOptions.IgnoreUnknownCharacters))
                    let decodedImage = UIImage(data: decodedImageString!)
                    shoeToAppend.shoeImage = decodedImage
                    tempShoeArray.append(shoeToAppend)
                }
            }

            completion(tempShoeArray,nil) //send data back to controller

            }, withCancelBlock: { error in
                print(error.description)
                completion(nil,nil) //send data back to controller
        })
    }

    func getOwnersShoes(completion:CompletionBlock.AnyObjArray){
        // Get a reference to our posts
        let shoeRef = FirebaseClient.sharedClient.getRefWith("shoes")
        //let shoeRef = Firebase.init(url: "https://kickswap.firebaseio.com/shoes")

        // Attach a closure to read the data at our posts reference
        shoeRef.observeEventType(.Value, withBlock: { snapshot in
            var tempShoeArray = [Shoe]()
            let dict = snapshot.value as! NSDictionary
            for x in dict {
                var shoeToAppend = Shoe(data: x.value as! NSDictionary)
                print(shoeToAppend.ownerId)
                print(User.currentUser?.uid)
                if shoeToAppend.ownerId == User.currentUser?.uid {
//                    tempShoeArray.append(shoeToAppend)
                    if(shoeToAppend.imageString != nil) {
                        let decodedImageString = NSData(base64EncodedString: shoeToAppend.imageString as! String, options: NSDataBase64DecodingOptions(arrayLiteral: NSDataBase64DecodingOptions.IgnoreUnknownCharacters))
                        let decodedImage = UIImage(data: decodedImageString!)
                        shoeToAppend.shoeImage = decodedImage
                        tempShoeArray.append(shoeToAppend)
                    }
                }
            }

            completion(tempShoeArray,nil) //send data back to controller

            }, withCancelBlock: { error in
                print(error.description)
                completion(nil,nil) //send data back to controller
        })

    }

    func getOwnersShoes(owner:User,completion:CompletionBlock.AnyObjArray){
        // Get a reference to our posts
        let shoeRef = FirebaseClient.sharedClient.getRefWith("shoes")
        //let shoeRef = Firebase.init(url: "https://kickswap.firebaseio.com/shoes")

        // Attach a closure to read the data at our posts reference
        shoeRef.observeEventType(.Value, withBlock: { snapshot in
            var tempShoeArray = [Shoe]()
            let dict = snapshot.value as! NSDictionary
            for x in dict {
                let shoeToAppend = Shoe(data: x.value as! NSDictionary)
                if shoeToAppend.ownerId == owner.uid && shoeToAppend.imageString != nil {
                    let decodedImageString = NSData(base64EncodedString: shoeToAppend.imageString as! String, options: NSDataBase64DecodingOptions(arrayLiteral: NSDataBase64DecodingOptions.IgnoreUnknownCharacters))
                    let decodedImage = UIImage(data: decodedImageString!)
                    shoeToAppend.shoeImage = decodedImage
                    tempShoeArray.append(shoeToAppend)
                }
            }

            print(tempShoeArray)

            completion(tempShoeArray,nil) //send data back to controller

            }, withCancelBlock: { error in
                print(error.description)
                completion(nil,nil) //send data back to controller
        })

    }


    func getUserById(userId: String, completion:CompletionBlock.KSUser){
        let userRef = getRefWith("users")
        userRef.observeEventType(.Value, withBlock: { snapshot in
            var tempUser: User?
            let dict = snapshot.value as! NSDictionary
            for x in dict {
                var userToAppend = User(dictionary: x.value as! NSDictionary)
                if "facebook:\(userToAppend.id!)" == userId {
                    tempUser = userToAppend
                    completion(tempUser,nil)
                }
            }

            }, withCancelBlock: { error in
                print(error.description)
                completion(nil,error)
        })
    }

    func getReleaseDate(completion:CompletionBlock.AnyObjArray)  {
        let ref = getRefWith(myURIs.catalog)
        ref.observeEventType(.Value, withBlock: { snapshot in
            if snapshot != nil {
                let response = snapshot.value as! NSDictionary
                let releases = response["releases"] as! NSDictionary
                var items = [Release]()
                for shoe in releases {
                    items.append(Release(name: shoe.key as! String, data: shoe.value as! NSDictionary))
                }

                completion(items,nil)

            } else {
                completion(nil,nil)
            }
        })
    }
    
    func addBid(toShoe:Shoe, bid: Bid){
        //let ref = getRefWith(myURIs.bids).childByAppendingPath("-KEfQU77wsUzYkaUihMM")
        print(toShoe)
        _ = getRefWith(myURIs.bids).childByAppendingPath(toShoe.uid!)
        print(bid.dict)
        
        if let ref = getRefWith(myURIs.bids).childByAppendingPath(toShoe.uid!) {
            ref.updateChildValues(bid.dict, withCompletionBlock: { (error, firebase) in
                if error == nil {
                    print("we sent it")
                } else {
                    print("Error: Add bid")
                }
                
            })
        }
    }
    
    func getBids(forShoe:Shoe){
        if let ref = getRefWith(myURIs.bids).childByAppendingPath(forShoe.uid){
            ref.observeEventType(.ChildAdded, withBlock: { snapshot in
                if snapshot != nil {
                    print(snapshot.value)
                } else {
                    
                }
            })
        }
        
//        let temp = getRefWith(myURIs.bids).childByAppendingPath("-KEfQU77wsUzYkaUihMM")
//        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
//            if snapshot != nil {
//                print(snapshot.value)
//            } else {
//                
//            }
//        })
    }
    

    func logOut() {
        return getRef().unauth()
    }

}
