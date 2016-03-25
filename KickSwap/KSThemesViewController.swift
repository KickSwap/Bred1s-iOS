//
//  KSThemesViewController.swift
//  KickSwap
//
//  Created by Brandon Sanchez on 3/24/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class KSThemesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var palletteView1: UIView!
    @IBOutlet var palletteView2: UIView!
    @IBOutlet var palletteView3: UIView!
    @IBOutlet var palletteView4: UIView!
    @IBOutlet var palletteView5: UIView!
    
    @IBOutlet var tableView: UITableView!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    var themeImageNamesArray = ["nike air max 95 neon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.allowsMultipleSelection = false
        // Do any additional setup after loading the view.
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
        
        for name in themeImageNamesArray {
            cell.cellBackgroundImage.image = UIImage(named: name)
            
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Style.availableThemes.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        defaults.setObject(Style.availableThemes[indexPath.row], forKey: "Theme")
        print(defaults.valueForKey("Theme"))
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
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
