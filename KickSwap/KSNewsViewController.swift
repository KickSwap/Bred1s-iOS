//
//  KSNewsViewController.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/25/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import PagingMenuController

class KSNewsViewController: UIViewController, PagingMenuControllerDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let niceKicksViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NiceKicksViewController") as! NiceKicksViewController
        let JisBackViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MJisBackViewController") as! MJisBackViewController
        let soleCollectorViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SoleCollectorViewController") as! SoleCollectorViewController
        niceKicksViewController.title = "Nice Kicks"
        JisBackViewController.title = "Release Dates"
        soleCollectorViewController.title = "Sole Collector"
        let viewControllers = [niceKicksViewController, JisBackViewController, soleCollectorViewController]
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        //pagingMenuController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let options = PagingMenuOptions()
        options.defaultPage = 0
        options.backgroundColor = UIColor.darkGrayColor()
        options.selectedBackgroundColor = UIColor.blackColor()
        options.textColor = UIColor.lightGrayColor()
        options.selectedTextColor = UIColor.whiteColor()
        options.menuHeight = 50
        //options.menuPosition = .Bottom
        pagingMenuController.delegate = self
        options.menuDisplayMode = .SegmentedControl
        //(widthMode: .Flexible, centerItem: true, scrollingMode: .PagingEnabled)
        //.Infinite(widthMode: .Flexible)
        //
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        
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
