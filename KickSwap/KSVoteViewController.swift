//
//  KSVoteViewController.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 3/16/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class KSVoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var voteResultsTableView: UITableView!
    var releaseDates:[Release]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.voteResultsTableView.delegate = self
        self.voteResultsTableView.dataSource = self
        
        FirebaseClient.sharedClient.getReleaseDate({ (shoes, error) in
            if error == nil { //YASSSS
                self.releaseDates = shoes as? [Release]
                self.voteResultsTableView.reloadData()
            } else {// What the..
                print(error)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if releaseDates != nil{
            return (releaseDates?.count)!
        } else {
            return 0
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VoteCell") as? KSVoteTableViewCell
        cell?.shoe = self.releaseDates![indexPath.row]
        return cell!
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
