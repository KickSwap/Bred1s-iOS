//
//  Themes.swift
//  KickSwap
//
//  Created by Brandon Sanchez on 3/20/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import Foundation
import ChameleonFramework

var profileTrayViewColor: UIColor?
var timelineBackgroundColor: UIColor?
var trayViewButtonImage: UIImage?
var shoeTagViewColor: UIColor?
var tabBarTintColor: UIColor?
var tabBarBarTintColor: UIColor?
var buyButtonImage: UIImage?
var sellButtonImage: UIImage?
var newsButtonImage: UIImage?
var menuButtonsColor: UIColor?
var pulseColor: UIColor?
var profileHeaderColor: UIColor?
var pagingMenuBackgroundColor: UIColor?
var pagingMenuSelectedBackgroundColor: UIColor?
var pagingMenuUnderlineColor: UIColor?
var pagingMenuTextColor: UIColor?
var pagingMenuSelectedTextColor: UIColor?
var toolbarColor: UIColor?
var textColor: UIColor?


struct Style{
    
    // MARK: Blue Color Schemes
    static func themeNeon(){
        //hex strings
        let quartsHex = "dbd7ef"
        let inchWormHex = "c3f350"
        let aluminumHex = "969b99"
        let fuscousGrayHex = "55534e"
        let blackHex = "050505"
        
        //UIColors
        let quarts = UIColor(hexString: quartsHex)
        let inchWorm = UIColor(hexString: inchWormHex)
        let aluminum = UIColor(hexString: aluminumHex)
        let fuscousGray = UIColor(hexString: fuscousGrayHex)
        let black = UIColor(hexString: blackHex)
        // MARK: ToDo Table Section Headers
        
        //KSTimeline Colors
        timelineBackgroundColor = GradientColor(UIGradientStyle.TopToBottom, frame: UIScreen.mainScreen().bounds, colors: [UIColor(hexString: "050505"), UIColor(hexString: "c3f350")])
        profileTrayViewColor = inchWorm
        trayViewButtonImage = UIImage(named: "")
        
        //KSTabBar Colors
        tabBarTintColor = quarts
        tabBarBarTintColor = aluminum
        
        //CollectionView Colors
        shoeTagViewColor = fuscousGray
        
        //Menu Button Images
        buyButtonImage = UIImage(named: "buyBlack")
        sellButtonImage = UIImage(named: "sellBlack")
        newsButtonImage = UIImage(named: "newsBlack")
        
        //Menu Button Colors
        menuButtonsColor = inchWorm
        pulseColor = fuscousGray
        
        //ProfileColors
        profileHeaderColor = aluminum
        
        //PagingMenu Colors
        pagingMenuBackgroundColor = aluminum
        pagingMenuSelectedBackgroundColor = fuscousGray
        pagingMenuUnderlineColor = inchWorm
        pagingMenuTextColor = fuscousGray
        pagingMenuSelectedTextColor = inchWorm
        toolbarColor = inchWorm
        
        //TextColor
        textColor = black
    }
    
    static let availableThemes = ["Solid Blue", "Pretty Pink", "Zen Black", "Light Blue", "Dark Blue", "Dark Green", "Dark Orange"]
    static func loadTheme() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("Theme"){
            // Select the Theme
            if name == "Neon"		{ Style.themeNeon()
                print("works")}
            if name == "Orange" {}
        }else{
            defaults.setObject("Neon", forKey: "Theme")
            themeNeon()
            print("yes")
        }
    }
}
