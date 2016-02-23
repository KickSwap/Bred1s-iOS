//
//  KSTimelineViewController.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/18/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
class KSTimelineViewController: UIViewController {
    
    var shoeTimeline: [Shoe]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOutPressed(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    //MARK: - Firebase Get Methods
    func getShoes() {
        // Get a reference to our posts
        let ref = FirebaseClient.getRefWith("shoes")
        
        // Attach a closure to read the data at our posts reference
        ref.observeEventType(.Value, withBlock: { snapshot in
            let dict = snapshot.value as! NSDictionary
            for x in dict {
                let shoeToAppend = Shoe(data: x.value as! NSDictionary)
                self.shoeTimeline?.append(shoeToAppend)
            }
            
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
