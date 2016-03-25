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
        timelineBackgroundColor = GradientColor(UIGradientStyle.TopToBottom, frame: UIScreen.mainScreen().bounds, colors: [black, fuscousGray, aluminum, inchWorm])
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
    
    static func themeCeltics() {
        //hex strings
        let solitudeHex = "ebe9f3"
        let genoaHex = "358062"
        let watercourseHex = "00784c"
        let cardinGreenHex = "203528"
        let darkJungleGreenHex = "1d1f1b"
        
        //UIColors
        let solitude = UIColor(hexString: solitudeHex)
        let genoa = UIColor(hexString: genoaHex)
        let watercourse = UIColor(hexString: watercourseHex)
        let cardinGreen = UIColor(hexString: cardinGreenHex)
        let darkJungleGreen = UIColor(hexString: darkJungleGreenHex)
        // MARK: ToDo Table Section Headers
        
        //KSTimeline Colors
        timelineBackgroundColor = GradientColor(UIGradientStyle.TopToBottom, frame: UIScreen.mainScreen().bounds, colors: [genoa, darkJungleGreen])
        profileTrayViewColor = genoa
        trayViewButtonImage = UIImage(named: "")
        
        //KSTabBar Colors
        tabBarTintColor = solitude
        tabBarBarTintColor = watercourse
        
        //CollectionView Colors
        shoeTagViewColor = darkJungleGreen
        
        //Menu Button Images
        buyButtonImage = UIImage(named: "buyBlack")
        sellButtonImage = UIImage(named: "sellBlack")
        newsButtonImage = UIImage(named: "newsBlack")
        
        //Menu Button Colors
        menuButtonsColor = darkJungleGreen
        pulseColor = solitude
        
        //ProfileColors
        profileHeaderColor = watercourse
        
        //PagingMenu Colors
        pagingMenuBackgroundColor = genoa
        pagingMenuSelectedBackgroundColor = cardinGreen
        pagingMenuUnderlineColor = solitude
        pagingMenuTextColor = cardinGreen
        pagingMenuSelectedTextColor = solitude
        toolbarColor = genoa
        
        //TextColor
        textColor = solitude

    }
    
    static func themeOlympics() {
        //hex strings
        let primHex = "eee4ee"
        let shadyLadyHex = "a9a2a4"
        let frenchBeigeHex = "a77f59"
        let tamarilloHex = "9c1313"
        let blackPearlHex = "1e2432"
        
        //UIColors
        let prim = UIColor(hexString: primHex)
        let shadyLady = UIColor(hexString: shadyLadyHex)
        let frenchBeige = UIColor(hexString: frenchBeigeHex)
        let tamarillo = UIColor(hexString: tamarilloHex)
        let blackPearl = UIColor(hexString: blackPearlHex)
        // MARK: ToDo Table Section Headers
        
        //KSTimeline Colors
        timelineBackgroundColor = GradientColor(UIGradientStyle.TopToBottom, frame: UIScreen.mainScreen().bounds, colors: [frenchBeige, prim])
        profileTrayViewColor = frenchBeige
        trayViewButtonImage = UIImage(named: "")
        
        //KSTabBar Colors
        tabBarTintColor = prim
        tabBarBarTintColor = tamarillo
        
        //CollectionView Colors
        shoeTagViewColor = blackPearl
        
        //Menu Button Images
        buyButtonImage = UIImage(named: "buyBlack")
        sellButtonImage = UIImage(named: "sellBlack")
        newsButtonImage = UIImage(named: "newsBlack")
        
        //Menu Button Colors
        menuButtonsColor = blackPearl
        pulseColor = tamarillo
        
        //ProfileColors
        profileHeaderColor = blackPearl
        
        //PagingMenu Colors
        pagingMenuBackgroundColor = frenchBeige
        pagingMenuSelectedBackgroundColor = prim
        pagingMenuUnderlineColor = frenchBeige
        pagingMenuTextColor = shadyLady
        pagingMenuSelectedTextColor = frenchBeige
        toolbarColor = shadyLady
        
        //TextColor
        textColor = blackPearl
    }
    
    static func themeAirMags() {
        //hex strings
        let athensGrayHex = "eeedf1"
        let pinkSwanHex = "bab6b5"
        let manateeHex = "919dab"
        let scooterHex = "37979f"
        //let blackPearlHex = "1e2432"
        
        //UIColors
        let athensGray = UIColor(hexString: athensGrayHex)
        let pinkSwan = UIColor(hexString: pinkSwanHex)
        let manatee = UIColor(hexString: manateeHex)
        let scooter = UIColor(hexString: scooterHex)
        //let blackPearl = UIColor(hexString: blackPearlHex)
        // MARK: ToDo Table Section Headers
        
        //KSTimeline Colors
        timelineBackgroundColor = GradientColor(UIGradientStyle.TopToBottom, frame: UIScreen.mainScreen().bounds, colors: [athensGray, scooter])
        profileTrayViewColor = athensGray
        trayViewButtonImage = UIImage(named: "")
        
        //KSTabBar Colors
        tabBarTintColor = scooter
        tabBarBarTintColor = manatee
        
        //CollectionView Colors
        shoeTagViewColor = scooter
        
        //Menu Button Images
        buyButtonImage = UIImage(named: "buyBlack")
        sellButtonImage = UIImage(named: "sellBlack")
        newsButtonImage = UIImage(named: "newsBlack")
        
        //Menu Button Colors
        menuButtonsColor = scooter
        pulseColor = athensGray
        
        //ProfileColors
        profileHeaderColor = athensGray
        
        //PagingMenu Colors
        pagingMenuBackgroundColor = scooter
        pagingMenuSelectedBackgroundColor = manatee
        pagingMenuUnderlineColor = UIColor.flatWhiteColor()
        pagingMenuTextColor = manatee
        pagingMenuSelectedTextColor = UIColor.flatWhiteColor()
        toolbarColor = scooter
        
        //TextColor
        textColor = UIColor.whiteColor()
    }
    
    static let availableThemes = ["Neon", "Celtics", "Olympics", "Air Mags"]
    static func loadTheme() {
        let defaults = NSUserDefaults.standardUserDefaults()
        //defaults.setObject("Olympics", forKey: "Theme")
        if let name = defaults.stringForKey("Theme"){
            // Select the Theme
            if name == "Neon"		{ Style.themeNeon() }
            if name == "Celtics" { themeCeltics() }
            if name == "Olympics" { themeOlympics() }
            if name == "Air Mags" { themeAirMags() }
        }else{
            defaults.setObject("Neon", forKey: "Theme")
            themeNeon()
            print("yes")
        }
    }
}
