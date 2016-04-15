//
//  KSActivityViewController.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 4/5/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//
//
//  KSActivityViewController.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 3/21/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.


import UIKit

class KSActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var notificationTableView: UITableView!
    let cellID = "NotificationCell"
    
    var notifs:[Notification]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        self.notificationTableView.delegate = self
        self.notificationTableView.dataSource = self
    
        let push1 = ["ownerId":"@kickswap", "message":"Welcome to Kickswap"]
        
        notifs = [Notification(data: push1)]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notifs != nil {
            return notifs!.count
        } else {
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID) as! KSNotificationTableViewCell
        
        cell.notification = notifs![indexPath.row]
        
        return cell
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