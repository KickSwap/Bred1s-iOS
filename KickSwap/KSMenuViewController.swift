//
//  KSMenuViewController.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/3/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Material

class KSMenuViewController: MenuViewController, UIGestureRecognizerDelegate {
	/// MenuView diameter.
	private let baseViewSize: CGSize = CGSizeMake(56, 56)

	/// MenuView inset.
	private let menuViewInset: CGFloat = 16

    //MenuView Constants
    private class myViews {
        var buy = "buy"
        var sell = "sell"
        var news = "news"
    }

    // CurrentViewController
    private var currentView:String?

    //NSUserDefaults
    let defaults = NSUserDefaults.standardUserDefaults()

    //Menu button dynamic image
    var menuButtonImage: UIImage?

	override func viewDidLoad() {
		super.viewDidLoad()
		prepareView()
		prepareMenuView()
        Style.loadTheme()
        
        //To prevent redundant segue, close menu properly
        //self.currentView = "buy"
        
        //To prevent unwrapping nil in setmainbtnimage()
        //menuButtonImage = "ic_buy_white"
	}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Style.loadTheme()
        setMainBtnImage()
        prepareView()
        prepareMenuView()
        print(NSUserDefaults.standardUserDefaults().valueForKey("Theme"))
        //prepareMenuView(color:white)
        //prepareMenView(color:black)
        print(menuButtonImage)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
        
		var image: UIImage? = UIImage(named: "view_carousel_white_24x24")
		let btn1: FabButton = FabButton()
        btn1.backgroundColor = menuButtonsColor
        btn1.pulseColor = pulseColor
        //To prevent wrong image for main menu button
        print(menuButtonImage)
        print(NSUserDefaults.standardUserDefaults().valueForKey("Theme"))
        if menuButtonImage == nil {
		btn1.setImage(buyButtonImage, forState: .Normal)
		btn1.setImage(buyButtonImage, forState: .Highlighted)
        } else {
        btn1.setImage(menuButtonImage, forState: .Normal)
        btn1.setImage(menuButtonImage, forState: .Highlighted)
            setMainBtnImage()
        }
		btn1.addTarget(self, action: #selector(KSMenuViewController.onTap(_:)), forControlEvents: .TouchUpInside)
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(KSMenuViewController.onPress(_:)))
        longPressGestureRecognizer.minimumPressDuration = 0.3
        btn1.addGestureRecognizer(longPressGestureRecognizer)
		menuView.addSubview(btn1)

		image = UIImage(named: "ic_sell_icon")
		let btn2: FabButton = FabButton()
		btn2.backgroundColor = menuButtonsColor
		btn2.setImage(sellButtonImage, forState: .Normal)
		btn2.setImage(sellButtonImage, forState: .Highlighted)
		menuView.addSubview(btn2)
		btn2.addTarget(self, action: #selector(KSMenuViewController.handleSellBtn), forControlEvents: .TouchUpInside)

		image = UIImage(named: "ic_news_white")
		let btn3: FabButton = FabButton()
		btn3.backgroundColor = menuButtonsColor
		btn3.setImage(newsButtonImage, forState: .Normal)
		btn3.setImage(newsButtonImage, forState: .Highlighted)
		menuView.addSubview(btn3)
		btn3.addTarget(self, action: #selector(KSMenuViewController.handleNewsBtn), forControlEvents: .TouchUpInside)

		image = UIImage(named: "view_carousel_white_24x24")
		let btn4: FabButton = FabButton()
		btn4.backgroundColor = menuButtonsColor
		btn4.setImage(buyButtonImage, forState: .Normal)
		btn4.setImage(buyButtonImage, forState: .Highlighted)
		menuView.addSubview(btn4)
		btn4.addTarget(self, action: #selector(KSMenuViewController.handleBuyBtn), forControlEvents: .TouchUpInside)

		// Initialize the menu and setup the configuration options.
		menuView.menu.baseViewSize = baseViewSize
		menuView.menu.views = [btn1, btn2, btn3, btn4]

		view.addSubview(menuView)

		menuView.translatesAutoresizingMaskIntoConstraints = false
		MaterialLayout.size(view, child: menuView, width: baseViewSize.width, height: baseViewSize.height)
		MaterialLayout.alignFromBottomLeft(view, child: menuView, bottom: 0, left: (view.bounds.size.width - baseViewSize.width)/2)
	}

    func setMainBtnImage() {
        //get starter btn
        let mainBtn = self.menuView.menu.views![0] as! FabButton
        //set btn image
        mainBtn.setImage(menuButtonImage, forState: .Normal)
        mainBtn.setImage(menuButtonImage, forState: .Highlighted)
    }

    func onPress(sender: UILongPressGestureRecognizer? = nil) {
        //handleMenu()
        menuViewController?.mainViewController.view.alpha = 0.5
        openMenu()
    }

    func onTap(sender: UITapGestureRecognizer? = nil) {
        let tabBarController = self.mainViewController as! UITabBarController
        if menuView.menu.opened {
            menuViewController?.mainViewController.view.alpha = 1
            closeMenu()
        } else {
            //reload data here
            
            return  tabBarController.selectedIndex = 1
        }
    }

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    //MARK: - TimelineView Controls
    func handleSellBtn() {
        
        //self.menuButtonImage = sellButtonImage
        //self.setMainBtnImage()

        //check if user is already on this view
        if currentView == "sell" {
            closeOurMenu() //close menu on our Tabbar
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
            self?.currentView = "sell"
            //remove opacity
            self!.menuViewController?.mainViewController.view.alpha = 1


            //self?.transitionFromMainViewController(BlueViewController(), options: [.TransitionCrossDissolve])
        }

    }

    func handleBuyBtn() {
        
        self.menuButtonImage = buyButtonImage
        self.setMainBtnImage()

        //check if user is already on this view
        if currentView == "buy" {
            closeOurMenu() //close menu on our Tabbar
            return
        }

        closeMenu { [weak self] in
            //getMainViewController
            let tabBarController = self?.mainViewController as! UITabBarController
            tabBarController.selectedIndex = 1
            let controllers = tabBarController.viewControllers

            //getNavigationController
            let nav = controllers![1] //second value in tabBar
            nav.performSegueWithIdentifier("toBuy", sender: self)
            self?.currentView = "buy"
            //remove opacity
            self!.menuViewController?.mainViewController.view.alpha = 1

            //self?.transitionFromMainViewController(BlueViewController(), options: [.TransitionCrossDissolve])
        }
    }


    func handleNewsBtn() {
        print(self.currentView)
        self.menuButtonImage = newsButtonImage
        setMainBtnImage()

        //check if user is already on this view
        if currentView == "news" {
            closeOurMenu() //close menu on our Tabbar
            return
        }

        closeMenu { [weak self] in
            //getMainViewController
            let tabBarController = self?.mainViewController as! UITabBarController
            tabBarController.selectedIndex = 1
            let controllers = tabBarController.viewControllers

            //getNavigationController
            let nav = controllers![1] //second value in tabBar
            nav.performSegueWithIdentifier("toNews", sender: self)
            self?.currentView = "news"

            //remove opacity
            self!.menuViewController?.mainViewController.view.alpha = 1
            
            //self?.transitionFromMainViewController(BlueViewController(), options: [.TransitionCrossDissolve])
        }
    }

    //MARK: - KickSwap Helpers
    func closeOurMenu() {
        closeMenu()
        self.menuViewController?.mainViewController.view.alpha = 1
    }
}
