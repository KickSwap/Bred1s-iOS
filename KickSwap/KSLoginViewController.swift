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
import LiquidLoader

class KSLoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    var firebaseClient = FirebaseClient.sharedClient

    @IBOutlet weak var loader: UIProgressView!
    var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter) / 100.0
            let animated = counter != 0
            
            loader.setProgress(fractionalProgress, animated: animated)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginBtn = FBSDKLoginButton()
        loginBtn.delegate = self
        loginBtn.center = self.view.center
        loginBtn.center = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height - 150)
        self.view.addSubview(loginBtn)
        loader.alpha = 0 //hide loader
    }

    override func viewDidAppear(animated: Bool) {
        if(User.currentUser != nil){
          self.performSegueWithIdentifier("LoginToTimeline", sender: nil) //takes care recurring case of userExisting
        } else {
            print("No Current User")
        }
    }

    // MARK: - Facebook Login Button
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
                // start loader here
        startLoader()
                if ((error) != nil) {
                        // Process error
                    }
                else if result.isCancelled {
                        // Handle cancellations
                    }
                else {
                    //If User is authenticated and ready to go
                    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                    FirebaseClient.sharedClient.loginWithFacebook(accessToken, completion: { (user, error) in
                        if(error == nil){
                            self.performSegueWithIdentifier("LoginToTimeline", sender: nil) //takes care recurring case of userExisting
                            self.loader.alpha = 0 //hide loader
                        } else {
                            print("Error: with Login")
                        }
                    
                    })
                }
        }
    
    func startLoader() {
        self.loader.alpha = 1 //show loader
        self.counter = 0
        for i in 0..<100 {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                sleep(1)
                dispatch_async(dispatch_get_main_queue(), {
                    self.counter++
                    return
                })
            })
        }
        
    }
    
    
    public func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        ///Should never worry about this
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
