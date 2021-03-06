//
//  NiceKicksViewController.swift
//  KickSwap
//
//  Created by Brandon Sanchez on 3/16/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class NiceKicksViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate, UIWebViewDelegate {

    let webVC = SwiftModalWebVC(urlString: "http://www.nicekicks.com/", theme: "Dark")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding & Sizing WebVC
        addChildViewController(webVC)
        webVC.didMoveToParentViewController(self)
        self.webVC.view.frame = view.frame
            
        //Pre-loading the webviews
        view.addSubview(webVC.view)
        view.bringSubviewToFront(webVC.view)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let swiftmodalVC = self.parentViewController
        let ksnews = swiftmodalVC?.parentViewController as! KSNewsViewController
        print(ksnews)
        ksnews.showMenuBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
