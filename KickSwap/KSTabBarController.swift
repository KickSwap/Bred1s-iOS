//
//  KSTabBarController.swift
//  KickSwap
//
//  Created by Brandon Sanchez on 3/10/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class KSTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        Style.loadTheme()
        self.selectedIndex = 1
        
        //set current User
        let profile = self.viewControllers![2] as! KSProfileViewController
        profile.profileUser = User.currentUser
        
        delegate = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        layoutTheme()
        self.selectedIndex = 1
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layoutTheme() {
        self.tabBar.tintColor = tabBarTintColor
        self.tabBar.barTintColor = tabBarBarTintColor
    }
    
    @IBAction func customizeTapped(segue: UIStoryboardSegue, sender: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        var fromIndex = 0
        var toIndex = 0
        
        for index in 0...viewControllers!.count - 1 {
            
            if viewControllers![index] == fromVC {
                fromIndex = index
            }
            if viewControllers![index] == toVC {
                toIndex = index
            }
        }
        
        return TabBarAnimatedTransitioning(fromIndex: fromIndex, toIndex: toIndex)
        
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
