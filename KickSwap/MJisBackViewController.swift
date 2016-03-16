//
//  MJisBackViewController.swift
//  KickSwap
//
//  Created by Brandon Sanchez on 3/16/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class MJisBackViewController: UIViewController {

    let webVC = SwiftModalWebVC(urlString: "http://www.23isback.com/", theme: "Dark")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(webVC)
        webVC.didMoveToParentViewController(self)
        self.webVC.view.frame = view.frame
        
        view.addSubview(webVC.view!)
        view.bringSubviewToFront(webVC.view!)
        // Do any additional setup after loading the view.
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
