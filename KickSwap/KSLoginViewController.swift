//
//  ViewController.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/3/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class KSLoginViewController: UIViewController {

    var firebaseClient = FirebaseClient.sharedClient

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        if(User.currentUser != nil){
          self.performSegueWithIdentifier("LoginToTimeline", sender: nil) //takes care recurring case of userExisting
        } else {
            print("No Current User")
        }
    }

    // MARK: - Facebook Login Button
    @IBAction func loginBtnPressed(sender: AnyObject) {
        let fbManager = FBSDKLoginManager()
        fbManager.logInWithReadPermissions(["public_profile", "email"], fromViewController: self) { (result, error) -> Void in
            if (error != nil || result == nil) {
                //Something went wrong with Facebook. Please try again later!",
                return
            } else if (result.isCancelled) {
                //user decided not login
                return
            } else if (!result.declinedPermissions.isEmpty) {
                //In order to obtain info from Facebook you must grant us permission. Alert Message")
                return
            }

            //If User is authenticated and ready to go
            let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
            FirebaseClient.sharedClient.loginWithFacebook(accessToken)
            self.performSegueWithIdentifier("LoginToTimeline", sender: nil) //takes care recurring case of userExisting

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
