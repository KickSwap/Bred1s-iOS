//
//  KSProfileViewController.swift
//  KickSwap
//
//  Created by Eric Suarez on 2/27/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Firebase
import AFNetworking
import WYInteractiveTransitions
import Material
import DZNEmptyDataSet

class KSProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var allShoes: [Shoe]?
    var currentUserShoesArray: [Shoe]?
    var profileUser:User?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet var themesButton: RaisedButton!
    @IBOutlet var profileHeaderView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var kicksLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
        
        profilePicImageView.layer.cornerRadius = 3
        profilePicImageView.clipsToBounds = true
        
        nameLabel.text = profileUser?.displayName
    
        profilePicImageView.setImageWithURL(NSURL(string: (profileUser?.profilePicUrl)!)!)
        
        getShoes()
        
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "Question-Rage-Face")
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "Where yo kicks at?"
        let myAttributes1 = [ NSForegroundColorAttributeName: UIColor.lightGrayColor() ]
        let attrString3 = NSAttributedString(string: "Where yo kicks at?", attributes: myAttributes1)
        return attrString3
    }
    
    override func viewWillAppear(animated: Bool) {
        layoutTheme()
        themesButtonLayout()
        profileHeaderView.setNeedsLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(timeline: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if allShoes != nil {
            return allShoes!.count
        } else {
            return 0
        }
    }
    
    func collectionView(timeline: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = timeline.dequeueReusableCellWithReuseIdentifier("ProfileCell", forIndexPath: indexPath) as! KSProfileCollectionViewCell
        
        cell.shoeImageView.clipsToBounds = true
        cell.shoeImageView.image = allShoes![indexPath.row].shoeImage
        cell.shoeNameLabel.text = allShoes![indexPath.row].name
        
        return cell
    }
    
    func getShoes() {
        // Get a reference to our posts
        
        FirebaseClient.sharedClient.getOwnersShoes({ (shoes, error) in
            if(error == nil) { //good to go
                self.allShoes = shoes as? [Shoe]
                self.kicksLabel.text = "\(self.allShoes!.count)"
                self.collectionView.reloadData()
            } else { //bad ting that..
                print("Error: In KSProfileViewController.GetShoes")
            }
        })
    }
    
    func layoutTheme() {
        self.kicksLabel.textColor = textColor
        nameLabel.textColor = textColor
        profileHeaderView.backgroundColor = profileHeaderColor
        self.view.backgroundColor = timelineBackgroundColor
    }
    
    let transitionMgr = WYInteractiveTransitions()
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "themeSegue" {
            let toView = segue.destinationViewController as? KSThemesViewController
            transitionMgr.configureTransition(0.5, toViewController: toView!,
                handGestureEnable: true, transitionType: WYTransitoinType.Zoom)
        }
    }
    
    // Unwind Segue
    @IBAction func customizeTapped(segue: UIStoryboardSegue, sender: UIStoryboardSegue) {
        //Figure out destination view controller, currently its timeline
//        let toView = segue.destinationViewController as? KSTabBarController
        
//        transitionMgr.configureTransition(0.5, toViewController: self,
//                    handGestureEnable: true, transitionType: WYTransitoinType.Zoom)
        //layoutTheme()
    }
    
    func themesButtonLayout() {
        themesButton.backgroundColor = MaterialColor.grey.lighten2
        themesButton.setTitle("Themes", forState: .Normal)
        themesButton.setTitleColor(MaterialColor.grey.darken2, forState: .Normal)
        themesButton.titleLabel?.font = RobotoFont.thinWithSize(12)
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
