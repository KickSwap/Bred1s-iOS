//
//  KSMenuViewController.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/3/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Material

class KSMenuViewController: MenuViewController {
	/// MenuView diameter.
	private let baseViewSize: CGSize = CGSizeMake(56, 56)
	
	/// MenuView inset.
	private let menuViewInset: CGFloat = 16
	
	override func viewDidLoad() {
		super.viewDidLoad()
		prepareView()
		prepareMenuView()
        //add long guesture tap
	}
	
	/// Loads the BlueViewController into the menuViewControllers mainViewController.
	func handleBlueButton() {
		if mainViewController is BlueViewController {
			return
		}

		closeMenu { [weak self] in
            //getMainViewController
            let tabBarController = self?.mainViewController as! UITabBarController
            tabBarController.selectedIndex = 1
            let controllers = tabBarController.viewControllers
            
            //getNavigationController
            let nav = controllers![1] //second value in tabBar
            nav.performSegueWithIdentifier("toSell", sender: self)
            
            self!.menuViewController?.mainViewController.view.alpha = 1

            //self?.transitionFromMainViewController(BlueViewController(), options: [.TransitionCrossDissolve])
		}
	}
	
	/// Loads the GreenViewController into the menuViewControllers mainViewController.
	func handleGreenButton() {
		if mainViewController is GreenViewController {
			return
		}
		
		closeMenu { [weak self] in
			self?.transitionFromMainViewController(GreenViewController(), options: [.TransitionCrossDissolve])
		}
	}
	
	/// Loads the YellowViewController into the menuViewControllers mainViewController.
	func handleYellowButton() {
		if (mainViewController as? NavigationBarViewController)?.mainViewController is YellowViewController {
			return
		}
		
		closeMenu { [weak self] in
			self?.transitionFromMainViewController(YellowViewController(), options: [.TransitionCrossDissolve])
		}
	}
	
	/// Handle the menuView touch event.
	func handleMenu() {
		if menuView.menu.opened {
			menuViewController?.mainViewController.view.alpha = 1
			closeMenu()
		} else {
			menuViewController?.mainViewController.view.alpha = 0.5
			openMenu()
		}
	}
	
	/// Prepares view.
	private func prepareView() {
		view.backgroundColor = MaterialColor.black
	}
	
	/// Prepares the add button.
	private func prepareMenuView() {
		var image: UIImage? = UIImage(named: "ic_add_white")
		let btn1: FabButton = FabButton()
        btn1.backgroundColor = MaterialColor.orange.base
		btn1.setImage(image, forState: .Normal)
		btn1.setImage(image, forState: .Highlighted)
		btn1.addTarget(self, action: "handleMenu", forControlEvents: .TouchUpInside)
		menuView.addSubview(btn1)
		
		image = UIImage(named: "ic_create_white")
		let btn2: FabButton = FabButton()
		btn2.backgroundColor = MaterialColor.blue.accent1
		btn2.setImage(image, forState: .Normal)
		btn2.setImage(image, forState: .Highlighted)
		menuView.addSubview(btn2)
		btn2.addTarget(self, action: "handleSellBtn", forControlEvents: .TouchUpInside)
		
		image = UIImage(named: "ic_photo_camera_white")
		let btn3: FabButton = FabButton()
		btn3.backgroundColor = MaterialColor.orange.base
		btn3.setImage(image, forState: .Normal)
		btn3.setImage(image, forState: .Highlighted)
		menuView.addSubview(btn3)
		btn3.addTarget(self, action: "handleGreenButton", forControlEvents: .TouchUpInside)
		
		image = UIImage(named: "ic_note_add_white")
		let btn4: FabButton = FabButton()
		btn4.backgroundColor = MaterialColor.orange.base
		btn4.setImage(image, forState: .Normal)
		btn4.setImage(image, forState: .Highlighted)
		menuView.addSubview(btn4)
		btn4.addTarget(self, action: "handleYellowButton", forControlEvents: .TouchUpInside)
		
		// Initialize the menu and setup the configuration options.
		menuView.menu.baseViewSize = baseViewSize
		menuView.menu.views = [btn1, btn2, btn3, btn4]
		
		view.addSubview(menuView)
		menuView.translatesAutoresizingMaskIntoConstraints = false
		MaterialLayout.size(view, child: menuView, width: baseViewSize.width, height: baseViewSize.height)
		MaterialLayout.alignFromBottomLeft(view, child: menuView, bottom: 0, left: (view.bounds.size.width - baseViewSize.width)/2)
	}
    
    //MARK: TimelineView Controls
    func handleSellBtn() {
        
        //getMainViewController >> TabBar
        let tabBarController = self.mainViewController as! UITabBarController
        tabBarController.selectedIndex = 1
        let controllers = tabBarController.viewControllers
        
        if controllers![1] is KSSellViewController {
            return
        }
        
        closeMenu { [weak self] in
            //getMainViewController
            //let tabBarController = self?.mainViewController as! UITabBarController
            tabBarController.selectedIndex = 1
            let controllers = tabBarController.viewControllers
            
            //getNavigationController
            let nav = controllers![1] //second value in tabBar
            nav.performSegueWithIdentifier("toSell", sender: self)
            
            //remove opacity
            self!.menuViewController?.mainViewController.view.alpha = 1
            
            //self?.transitionFromMainViewController(BlueViewController(), options: [.TransitionCrossDissolve])
        }

    }
    func handleBuyBtn() {}
    func handleNewsBtn() {}
}

