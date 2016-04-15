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

struct Variables {
    static var animatePagingMenu = false
}

class KSNewsViewController: UIViewController, PagingMenuControllerDelegate, UIScrollViewDelegate {

    let options = PagingMenuOptions()
    let PMenuController: PagingMenuController! = nil
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instantiateMenuController()
        
        // Do any additional setup after loading the view.
    }
    
    func instantiateMenuController() {
        //Instantiating Paging View Controllers
        let niceKicksViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NiceKicksViewController") as! NiceKicksViewController
        let JisBackViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ReleaseNewsController") as! KSVoteViewController
        let soleCollectorViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SoleCollectorViewController") as! SoleCollectorViewController
        niceKicksViewController.title = "Nice Kicks"
        JisBackViewController.title = "Release Dates"
        soleCollectorViewController.title = "Sole Collector"
        self.viewControllers = [niceKicksViewController, JisBackViewController, soleCollectorViewController]
        
        //Instantiating paging menu controller
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        //pagingMenuController.menuView.hidden = true
        //pagingMenuController.view.translatesAutoresizingMaskIntoConstraints = false
        
        //Customizing Paging Menu Controller
        //let options = PagingMenuOptions()
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
        //.Standard(widthMode: .Flexible, centerItem: true, scrollingMode: .PagingEnabled)
        //.Infinite(widthMode: .Flexible)
        //
        
        //Adding view controllers and customizztion to paging menu controller
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Adding view controllers and customizztion to paging menu controller
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        showTabBar()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

//Animate MenuView
    func hideMenuBar() {
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.animateMenuView()
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            self.menuViewController?.menuView.alpha = 0
            }, completion: { (Bool) in
        })
        hideTabBar()
    }
    
    func showMenuBar(animated animated: Bool = true) {
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.showMenuView()
        print(self.parentViewController)
        //self.tabBarController?.tabBar.hidden = false
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { 
            self.menuViewController?.menuView.alpha = 1
        }, completion: { (Bool) in
        })
        showTabBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//Animate TabBar    
    func showTabBar() {
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = CGRectGetMaxY(self.view.frame) - CGRectGetMaxY((self.tabBarController?.tabBar.frame)!)
//        print(offsetY)
//        print(CGRectGetMaxY(self.view.frame))
//        print(CGRectGetMaxY((self.tabBarController?.tabBar.frame)!))
        
        // zero duration means no animation
        let duration:NSTimeInterval = (0.4)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY)
                return
                }, completion: { (Bool) in
            })
            
        }

    }
    
    func hideTabBar() {
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (height!)
//        print(offsetY)
//        print(CGRectGetMaxY(self.view.frame))
//        print(CGRectGetMaxY((self.tabBarController?.tabBar.frame)!))
        
        // zero duration means no animation
        let duration:NSTimeInterval = (0.4)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
                //self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY!)
                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY)
                return
                }, completion: { (Bool) in
            })
            
        }
        

    }
    
//    func setTabBarVisible(visible:Bool, animated:Bool) {
//        
//        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
//        
//        // bail if the current state matches the desired state
//        if (tabBarIsVisible() == visible) {
//            print(tabBarIsVisible().boolValue)
//            self.menuViewController?.menuView.alpha = 1
//            return
//        }
//        
//        // get a frame calculation ready
//        let frame = self.tabBarController?.tabBar.frame
//        let height = frame?.size.height
//        let offsetY = (visible ? -height! : height)
//        
//        // zero duration means no animation
//        let duration:NSTimeInterval = (animated ? 0.4 : 10)
//        
//        //  animate the tabBar
//        if frame != nil {
//            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
//                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY!)
//                //self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, 0)
//                return
//                }, completion: { (Bool) in
//            })
//            
//        }
//        
//    }
//    
//    func tabBarIsVisible() ->Bool {
//        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
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
