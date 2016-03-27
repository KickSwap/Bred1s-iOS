//
//  KSNewsViewController.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/25/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import PagingMenuController
import Material

class KSNewsViewController: UIViewController, PagingMenuControllerDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Instantiating Paging View Controllers
        let niceKicksViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NiceKicksViewController") as! NiceKicksViewController
        let JisBackViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MJisBackViewController") as! MJisBackViewController
        let soleCollectorViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SoleCollectorViewController") as! SoleCollectorViewController
        niceKicksViewController.title = "Nice Kicks"
        JisBackViewController.title = "Release Dates"
        soleCollectorViewController.title = "Sole Collector"
        let viewControllers = [niceKicksViewController, JisBackViewController, soleCollectorViewController]
        
        //Instantiating paging menu controller
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        //pagingMenuController.view.translatesAutoresizingMaskIntoConstraints = false
        
        //Customizing Paging Menu Controller
        let options = PagingMenuOptions()
        options.defaultPage = 0
        options.backgroundColor = pagingMenuBackgroundColor!
        options.selectedBackgroundColor = pagingMenuSelectedBackgroundColor!
        options.textColor = pagingMenuTextColor!
        options.selectedTextColor = pagingMenuSelectedTextColor!
        options.font = RobotoFont.bold
        options.selectedFont = RobotoFont.bold
        options.menuHeight = 50
        options.menuItemMode = .Underline(height: 5, color: pagingMenuUnderlineColor!, horizontalPadding: 0, verticalPadding: 0)
        //options.menuPosition = .Bottom
        pagingMenuController.delegate = self
        options.menuDisplayMode = .SegmentedControl
        //(widthMode: .Flexible, centerItem: true, scrollingMode: .PagingEnabled)
        //.Infinite(widthMode: .Flexible)
        //
        
        //Adding view controllers and customizztion to paging menu controller
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        //Adding view controllers and customizztion to paging menu controller
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
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
