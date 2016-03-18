//
//  KSProfileViewController.swift
//  KickSwap
//
//  Created by Eric Suarez on 2/27/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Firebase
import AFNetworking

class KSProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var allShoes: [Shoe]?
    var currentUserShoesArray: [Shoe]?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var kicksLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        profilePicImageView.layer.cornerRadius = 3
        profilePicImageView.clipsToBounds = true
        
        nameLabel.text = User.currentUser?.displayName
        profilePicImageView.setImageWithURL(NSURL(string: (User.currentUser?.profilePicUrl)!)!)
        getShoes()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(timeline: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if allShoes != nil {
            return allShoes!.count
        } else {
            return 0
        }
    }
    
    func collectionView(timeline: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = timeline.dequeueReusableCellWithReuseIdentifier("ProfileCell", forIndexPath: indexPath) as! KSProfileCollectionViewCell
        
        cell.shoeImageView.clipsToBounds = true
        cell.shoeImageView.image = allShoes![indexPath.row].shoeImage
        cell.shoeNameLabel.text = allShoes![indexPath.row].name
        
        return cell
    }
    
    func getShoes() {
        // Get a reference to our posts
        let shoeRef = FirebaseClient.getRefWith("shoes")
        //let shoeRef = Firebase.init(url: "https://kickswap.firebaseio.com/shoes")
        
        // Attach a closure to read the data at our posts reference
        shoeRef.observeEventType(.Value, withBlock: { snapshot in
            var tempShoeArray = [Shoe]()
            let dict = snapshot.value as! NSDictionary
            for x in dict {
                var shoeToAppend = Shoe(data: x.value as! NSDictionary)
                if shoeToAppend.ownerId == User.currentUser?.uid && shoeToAppend.imageString != nil {
                    var decodedImageString = NSData(base64EncodedString: shoeToAppend.imageString as! String, options: NSDataBase64DecodingOptions(arrayLiteral: NSDataBase64DecodingOptions.IgnoreUnknownCharacters))
                    var decodedImage = UIImage(data: decodedImageString!)
                    shoeToAppend.shoeImage = decodedImage
                    print(shoeToAppend.shoeImage)
                    print(decodedImage)
                    tempShoeArray.append(shoeToAppend)
                }
            }
            
            //print(tempShoeArray)
            self.allShoes = tempShoeArray
            //self.filterShoes(tempShoeArray)
            self.kicksLabel.text = "\(tempShoeArray.count)"
            self.collectionView.reloadData()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
