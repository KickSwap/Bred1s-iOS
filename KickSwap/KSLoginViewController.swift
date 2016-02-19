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

class KSLoginViewController: UIViewController, FBSDKLoginButtonDelegate, FirebaseLoginDelegate {
    
    var loggedIn: Bool?
    
    var firebaseClient = FirebaseClient.sharedClient
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseClient.loginDelegate = self
        
        if User.currentUser == nil {
            loggedIn = false
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        let loginBtn = FBSDKLoginButton()
        loginBtn.delegate = self
        loginBtn.center = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height - 150)
        self.view.addSubview(loginBtn)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (User.currentUser != nil && loggedIn == true) {
            self.performSegueWithIdentifier("LoginToTimeline", sender: nil)
        } else {
            print("No Current User")
        }
    }

    // MARK: - Facebook Login Button
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if ((error) != nil) {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // Navigate to other view
            let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
            FirebaseClient.sharedClient.loginWithFacebook(accessToken)
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - FirebaseClient Protocols
    func loginCompletion() -> Void {
        loggedIn = true //set flag to allow login
    }
    
    func loginFailure(error: NSError?) -> Void {
        print("Login error: \(error)")
    }
}

