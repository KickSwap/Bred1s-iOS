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
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        print(User.currentUser?.uid)
        print(User.currentUser)
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
        
        cell.shoeImageView.setImageWithURL(NSURL(string: allShoes![indexPath.row].imageURL!)!)
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
                tempShoeArray.append(shoeToAppend)
            }
            
            //print(tempShoeArray)
            self.allShoes = tempShoeArray
            self.collectionView.reloadData()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }
    
//    func filterShoes(shoeArray: [Shoe]) {
//        var tempShoeArray = [Shoe]()
//        for s in shoeArray {
//            if s.owner?.uid == User.currentUser!.uid {
//                tempShoeArray.append(s)
//            }
//            print(s.owner!.uid)
//        }
//        
//        print(tempShoeArray)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
