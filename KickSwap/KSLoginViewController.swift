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

class KSLoginViewController: UIViewController, FBSDKLoginButtonDelegate, FirebaseLoginHandler {
    
    var loggedIn: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginBtn = FBSDKLoginButton()
        loginBtn.delegate = self
        loginBtn.center = self.view.center
        self.view.addSubview(loginBtn)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
            FirebaseClient.loginWithFacebook(accessToken, handler: self)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - FirebaseClient Protocols
    func loginCompletion() -> Void {
        //perform segueway to next screen
        //self.performSegueWithIdentifier("LoginToTimeline", sender: nil)
        loggedIn = true
    }
    
    func loginFailure(error: NSError?) -> Void {
        print("Login error: \(error)")
    }
}

