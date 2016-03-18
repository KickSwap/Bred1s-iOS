//
//  KSTimelineViewController.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 2/18/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Material
import ChameleonFramework
import IBAnimatable
import SnapKit

class KSTimelineViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, TextDelegate, TextViewDelegate {
    
   // @IBOutlet var timelineBackground: AnimatableImageView!
    @IBOutlet weak var timelineBackground: AnimatableImageView!
   // @IBOutlet var timeline: UICollectionView!
    @IBOutlet weak var timeline: UICollectionView!
   
   // @IBOutlet var userProfileImage: UIImageView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet var profileTrayView: UIView!
    @IBOutlet var trayViewButton: UIButton!
    var trayOriginalCenter: CGPoint!
    var tapCount = 0
    
    var shoeTimeline: [Shoe]?
    let backgroundImages = [UIImage(named:"blackBox"),UIImage(named:"boxStack"),UIImage(named:"greenBox")]
    var pictureIndex:Int?
    

    /// A Text storage object that monitors the changes within the textView.
    lazy var text: Text = Text()
    
    /// A TextView UI Component.
    var textView: TextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getShoesFromFirebase()
        prefersStatusBarHidden()
        timeline.dataSource = self
        timeline.delegate = self
        userProfileImage.image = UIImage(named: "JHarden")
        userProfileImage.clipsToBounds = true
        prepareView()
        prepareTextView()
        addToolBar(textView)
        
        //set image initially
        pictureIndex = 0
        timelineBackground.image = backgroundImages[pictureIndex!]
        
        
        //start timer
        var timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("loadImage"), userInfo: nil, repeats: true)

    }
    
    func loadImage(){
        //setImage2
        var newIndex = pictureIndex!++
        if newIndex > 1 {
            pictureIndex = 0
            newIndex = pictureIndex!
        }
        
        UIView.transitionWithView(self.timelineBackground,
            duration:5,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: { self.timelineBackground.image = self.backgroundImages[newIndex]},
            completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        // set initial tray view location
        self.profileTrayView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo((profileTrayView.superview?.frame.height)! * 0.82).constraint
        }
        
    }
    
    /// General preparation statements.
    private func prepareView() {
        view.backgroundColor = UIColor.clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    /// Prepares the textView.
    func prepareTextView() {
        let layoutManager: NSLayoutManager = NSLayoutManager()
        let textContainer: NSTextContainer = NSTextContainer(size: view.bounds.size)
        layoutManager.addTextContainer(textContainer)
        
        text.delegate = self
        text.textStorage.addLayoutManager(layoutManager)
        
        
        textView = TextView(textContainer: textContainer)
        textView.backgroundColor = UIColor.clearColor()
        textView.delegate = self
        textView.font = RobotoFont.regular
        textView.textColor = UIColor.whiteColor()
        textView.textContainer.maximumNumberOfLines = 1
        
        textView.placeholderLabel = UILabel()
        textView.placeholderLabel!.textColor = MaterialColor.white
        textView.placeholderLabel!.text = "Discover"
        
        // Discover label
        textView.titleLabel = UILabel()
        textView.titleLabel!.font = RobotoFont.mediumWithSize(12)
        textView.titleLabelColor = MaterialColor.white
        textView.titleLabelActiveColor = UIColor(hexString: "FA4A07")
        
        view.addSubview(textView)
        textView!.translatesAutoresizingMaskIntoConstraints = false
        MaterialLayout.alignToParent(view, child: textView!, top: 40, left: 24, bottom: 608, right: 100)
    }
    
    func addToolBar(textView: UITextView){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(hexString: "FA4A07")
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "discoverPressed")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelPressed")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        toolBar.sizeToFit()
        
        textView.delegate = self
        textView.inputAccessoryView = toolBar
    }
    func discoverPressed(){
        view.endEditing(true)
    }
    func cancelPressed(){
        view.endEditing(true) // or do something
    }
    
    /**
     When changes in the textView text are made, this delegation method
     is executed with the added text string and range.
     */
    func textWillProcessEdit(text: Text, textStorage: TextStorage, string: String, range: NSRange) {
        textStorage.removeAttribute(NSFontAttributeName, range: range)
        textStorage.addAttribute(NSFontAttributeName, value: RobotoFont.regular, range: range)
    }
    
    /**
     When a match is detected within the textView text, this delegation
     method is executed with the added text string and range.
     */
    func textDidProcessEdit(text: Text, textStorage: TextStorage, string: String, result: NSTextCheckingResult?, flags: NSMatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) {
        textStorage.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(16), range: result!.range)
    }
    

    
    @IBAction func onTrayPanGesture(sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view's coordinate system
        let point = sender.locationInView(view)
        
        // Total translation (x,y) over time in parent view's coordinate system
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            trayOriginalCenter = profileTrayView.center
        } else if sender.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
            profileTrayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
            let velocity = sender.velocityInView(view)
            if velocity.y > 0 {
                self.profileTrayView.snp_remakeConstraints { (make) -> Void in
                    //make.top.equalTo(self.timeline.snp_bottom)
                    make.top.equalTo((profileTrayView.superview?.frame.height)! * 0.82)
                }
                //profileTrayView.superview?.userInteractionEnabled = true
                profileTrayView.setNeedsLayout()
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    //self.trayView.center = self.trayDown
                    self.profileTrayView.layoutIfNeeded()
                    }, completion: { (Bool) -> Void in
                })
            } else {
                self.profileTrayView.snp_remakeConstraints { (make) -> Void in
                    make.top.equalTo((profileTrayView.superview?.snp_top)!)
                }
                //trayView.superview?.userInteractionEnabled = false
                //ignoreView.hidden = false
                textView.userInteractionEnabled = false
                textView.hidden = true
                profileTrayView.setNeedsLayout()
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    //self.trayView.center = self.trayUp
                    self.profileTrayView.layoutIfNeeded()
                    }, completion: { (Bool) -> Void in
                })
            }
        }
        

    }
    
    @IBAction func onTapTrayViewButton(sender: AnyObject) {
        
        tapCount++
        //print(tapCount)
        if tapCount % 2 == 0 {
            self.profileTrayView.snp_remakeConstraints { (make) -> Void in
                make.top.equalTo((profileTrayView.superview?.frame.height)! * 0.82).constraint
            }
            //ignoreView.userInteractionEnabled = false
            //ignoreView.hidden = true
            profileTrayView.setNeedsLayout()
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options:[] , animations: { () -> Void in
                //self.trayView.center = self.trayUp
                self.profileTrayView.layoutIfNeeded()
                }, completion: { (Bool) -> Void in
            })
            
        } else {
            self.profileTrayView.snp_remakeConstraints { (make) -> Void in
                make.top.equalTo((profileTrayView.superview?.snp_top)!).offset(0).constraint
            }
            //trayView.superview?.userInteractionEnabled = false
            //ignoreView.hidden = false
            textView.userInteractionEnabled = false
            textView.hidden = true
            profileTrayView.setNeedsLayout()
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options:[] , animations: { () -> Void in
                //self.trayView.center = self.trayDown
                self.profileTrayView.layoutIfNeeded()
                }, completion: { (Bool) -> Void in
            })
        }

    }
   

    @IBAction func logOutPressed(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func collectionView(timeline: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if shoeTimeline != nil {
            return (shoeTimeline?.count)!
        } else {
            return 0
        }
    }
    
    func collectionView(timeline: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = timeline.dequeueReusableCellWithReuseIdentifier("TimelineCell", forIndexPath: indexPath) as! KSTimelineCollectionViewCell
        
        cell.shoeNameLabel.text = shoeTimeline![indexPath.row].name
        cell.shoeImageView.image = shoeTimeline![indexPath.row].shoeImage
        cell.sizeLabel.text = shoeTimeline![indexPath.row].size!
        cell.conditionLabel.text = shoeTimeline![indexPath.row].condition
        
        return cell
    }
    
    //MARK: - Firebase Get Methods
    func getShoesFromFirebase() {
        //Correct way
//        self.shoeTimeline = FirebaseClient.getShoes()
        
        // Get a reference to our posts
        let shoeRef = FirebaseClient.getRefWith("shoes")

        //let shoeRef = Firebase.init(url: "https://kickswap.firebaseio.com/shoes")
        
        // Attach a closure to read the data at our posts reference
        shoeRef.observeEventType(.Value, withBlock: { snapshot in
            var tempShoeArray = [Shoe]()
            let dict = snapshot.value as! NSDictionary
            for x in dict {
                var shoeToAppend = Shoe(data: x.value as! NSDictionary)
                if shoeToAppend.imageString != nil {
                    var decodedImageString = NSData(base64EncodedString: shoeToAppend.imageString as! String, options: NSDataBase64DecodingOptions(arrayLiteral: NSDataBase64DecodingOptions.IgnoreUnknownCharacters))
                    var decodedImage = UIImage(data: decodedImageString!)
                    shoeToAppend.shoeImage = decodedImage
                    tempShoeArray.append(shoeToAppend)
                }
            }
            
            self.shoeTimeline = tempShoeArray
            self.timeline.reloadData()
            
            }, withCancelBlock: { error in
                print(error.description)
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
