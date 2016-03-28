//
//  KSThemesViewController.swift
//  KickSwap
//
//  Created by Brandon Sanchez on 3/24/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Material
import IBAnimatable

class KSThemesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var palletteView1: UIView!
    @IBOutlet var palletteView2: UIView!
    @IBOutlet var palletteView3: UIView!
    @IBOutlet var palletteView4: UIView!
    @IBOutlet var palletteView5: UIView!
    
    @IBOutlet var currentThemeLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    //custom checkmark
    var selectedRow: NSIndexPath?
    var checkmark: AnimatableImageView = AnimatableImageView(frame: CGRectMake(10, 10, 36, 36))
    var noCheckmark: UIImageView = UIImageView(frame: CGRectMake(0, 0, 0, 0))
    //var checkmarkImage = UIImage(named: "check_circle_white_96x96")
    
    var themeImageNamesArray = ["Air Max 95 Neon", "Jordan 1 Celtic", "Jordan 7 Olympic", "Nike Air Mags"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.allowsMultipleSelection = false
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.palletteView1.backgroundColor = palletteView1Color
        self.palletteView2.backgroundColor = palletteView2Color
        self.palletteView3.backgroundColor = palletteView3Color
        self.palletteView4.backgroundColor = palletteView4Color
        self.palletteView5.backgroundColor = palletteView5Color
        self.view.backgroundColor = UIColor.flatGrayColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dissmissView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ThemesTableViewCell", forIndexPath: indexPath) as! ThemesTableViewCell
        cell.selectionStyle = .None
        
        cell.cellBackgroundImage.image = UIImage(named: themeImageNamesArray[indexPath.row])
        cell.themesLabel.text = themeImageNamesArray[indexPath.row]
        cell.themesLabel.textColor = UIColor.flatBlackColorDark()
        cell.themesLabel.font = RobotoFont.bold
        self.checkmark.image = UIImage(named: "check_circle_white_96x96")
        self.noCheckmark.image = UIImage(named: "")
        //checkmark.alpha = 0
        //tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = self.checkmark
        //cell.accessoryView = self.checkmark
        if indexPath == selectedRow {
            // set checkmark image
//            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: [], animations: { () -> Void in
//                self.checkmark.alpha = 1
//                }, completion: { (completed) -> Void in
//            })
            //cell.accessoryView = self.checkmark
            //self.checkmark.alpha = 1
//            self.checkmark.image = UIImage(named: "check_circle_white_96x96")
//            cell.addSubview(checkmark)
        } else {
            // set no image
//            UIView.animateWithDuration(1, delay: 0, options: [], animations: { () -> Void in
//                self.checkmark.alpha = 0
//                }, completion: { (Bool) -> Void in
//            })
        }
    
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Style.availableThemes.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        //tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = self.checkmark
        
//        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: [], animations: { () -> Void in
//            //tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = self.checkmark
//            //self.checkmark.alpha = 1
//                            }, completion: { (completed) -> Void in
//                        })
        defaults.setObject(Style.availableThemes[indexPath.row], forKey: "Theme")
        print(defaults.valueForKey("Theme"))
        currentThemeLabel.text = themeImageNamesArray[indexPath.row]
        
        //Custom Checkmark
//        let paths:[NSIndexPath]
//        
//        if let previous = selectedRow {
//            paths = [indexPath, previous]
//        } else {
//            paths = [indexPath]
//        }
//        selectedRow = indexPath
//        tableView.reloadRowsAtIndexPaths(paths, withRowAnimation: .None)

        Style.loadTheme()
        
        //Pallette Animations
//        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
//            self.palletteView1.backgroundColor = palletteView1Color
//            }, completion: { (Bool) -> Void in
//                UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
//                    self.palletteView2.backgroundColor = palletteView2Color
//                    }, completion: { (Bool) -> Void in
//                        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
//                            self.palletteView3.backgroundColor = palletteView3Color
//                            }, completion: { (Bool) -> Void in
//                                UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
//                                    self.palletteView4.backgroundColor = palletteView4Color
//                                    }, completion: { (Bool) -> Void in
//                                        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
//                                            self.palletteView5.backgroundColor = palletteView5Color
//                                        }, completion: nil)
//                        })
//                })
//            })
//        })
        print("didnt make it")
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = self.noCheckmark

        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            //self.checkmark.alpha = 0
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = self.noCheckmark
            }, completion: { (completed) -> Void in
        })
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

