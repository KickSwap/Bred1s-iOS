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

class KSTimelineViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, CardAnimationViewDataSource, TextDelegate, TextViewDelegate {
    
    public weak var dataSourceDelegate : CardAnimationViewDataSource?
    
    
   // @IBOutlet var timelineBackground: AnimatableImageView!
    @IBOutlet weak var timelineBackground: AnimatableImageView!
   // @IBOutlet var timeline: UICollectionView!
    @IBOutlet weak var timeline: UICollectionView!
   
    @IBOutlet var panGestureAreaView: ImageCardView!
   // @IBOutlet var userProfileImage: UIImageView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet var profileTrayView: AnimatableView!
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
        prefersStatusBarHidden()
        timeline.dataSource = self
        timeline.delegate = self
        userProfileImage.image = UIImage(named: "JHarden")
        userProfileImage.clipsToBounds = true
        prepareView()
        prepareTextView()
        addToolBar(textView)
        getShoes()
        //profileTrayView.dataSourceDelegate = self
        
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
        return 5
    }
    
    func collectionView(timeline: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = timeline.dequeueReusableCellWithReuseIdentifier("TimelineCell", forIndexPath: indexPath) as! KSTimelineCollectionViewCell
        
        return cell
    }
    
    //MARK: - Firebase Get Methods
    func getShoes() {
        // Get a reference to our posts
        let ref = FirebaseClient.getRefWith("shoes")
        
        // Attach a closure to read the data at our posts reference
        ref.observeEventType(.Value, withBlock: { snapshot in
            var shoeArray = [Shoe]()
            let dict = snapshot.value as! NSDictionary
            for x in dict {
                let shoeToAppend = Shoe(data: x.value as! NSDictionary)
                shoeArray.append(shoeToAppend)
            }
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }
    
    func numberOfCards() -> Int {
       return 3
    }
    
    func numberOfVisibleCards() -> Int {
      return  1
    }
    
    func cardNumber(number: Int, reusedView: BaseCardView?) -> BaseCardView {
        var retView : ImageCardView? = reusedView as? ImageCardView
        if retView == nil {
            retView = panGestureAreaView //ImageCardView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        } else {
            print(" ✌️ View Cached ✌️ ")
        }
        //retView!.imageView.image = UIImage(named: "JHarden")
        return retView!
    }
    
    private lazy var flipUpTransform3D : CATransform3D = {
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 1000.0
        //transform = CATransform3DRotate(transform, CGFloat(-M_PI), 1, 0, 0)
        transform = CATransform3DRotate(transform, 0, 1, 0, 0)
        return transform
    }()
    
    private lazy var flipDownTransform3D : CATransform3D = {
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 1000.0
        transform = CATransform3DRotate(transform, CGFloat(-M_PI), 1, 0, 0)
        return transform
    }()

    func flipUp() {
        
        //currentIndex--
        
        //let newView = addNewCardViewWithIndex(currentIndex)
        //profileTrayView.layer.transform = flipDownTransform3D
        
        //let shouldRemoveLast = cardArray.count > maxVisibleCardCount
        
        UIView.animateKeyframesWithDuration(1, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1, animations: {
                self.panGestureAreaView.layer.transform = self.flipUpTransform3D
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.01, animations: {
                //self.profileTrayView.layoutSubviews()
            })
            
            }, completion: { _ in
                //self.relayoutSubViewsAnimated(true, removeLast: shouldRemoveLast)
                //self.profileTrayView.hidden = false
        })
        
    }
    
    func flipDown() {
        
        //currentIndex--
        
        //let newView = addNewCardViewWithIndex(currentIndex)
        //profileTrayView.layer.transform = flipUpTransform3D
        
        //let shouldRemoveLast = cardArray.count > maxVisibleCardCount
        
        UIView.animateKeyframesWithDuration(1, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1.5, animations: {
                self.panGestureAreaView.layer.transform = self.flipDownTransform3D
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.01, animations: {
                //self.profileTrayView.slideInDown()
                //self.profileTrayView.hidden = true
            })
            
            }, completion: { _ in
                //self.relayoutSubViewsAnimated(true, removeLast: shouldRemoveLast)
                //self.profileTrayView.hidden = true
        })
        
    }


    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //profileTrayView.flipDown()
//        profileTrayView.animationType = "FadeOutDown"
////        profileTrayView.delay = 0
////        profileTrayView.damping = 0.5
////        profileTrayView.velocity = 2
//        profileTrayView.force = 1
//        profileTrayView.fadeOutDown()
//        UIView.transitionWithView(profileTrayView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { self.profileTrayView = self.profileTrayView}, completion: { (value: Bool) in
//            //self.profileTrayView.alpha = 0
//        })
        //flipDown()
        //profileTrayView.layer.transform = flipDownTransform3D
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //flipDown()
//        UIView.transitionWithView(profileTrayView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { self.profileTrayView = self.profileTrayView}, completion: { (value: Bool) in
//            //            //self.profileTrayView.hidden = true
//                   })
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //flipUp()
//        UIView.transitionWithView(profileTrayView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { self.profileTrayView = self.profileTrayView}, completion: { (value: Bool) in
//                        //self.profileTrayView.alpha = 1
//        })
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        UIView.transitionWithView(profileTrayView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { self.profileTrayView = self.profileTrayView}, completion: { (value: Bool) in
            //self.profileTrayView.alpha = 1
        })
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        UIView.transitionWithView(profileTrayView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { self.profileTrayView = self.profileTrayView}, completion: { (value: Bool) in
//            self.profileTrayView.hidden = false
//            })
//        UIView.transitionWithView(profileTrayView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { self.profileTrayView = self.profileTrayView}, completion: { (value: Bool) in
//            //            //self.profileTrayView.hidden = true
//                    })

        //flipUp()
    }
    
//    UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
//    self.birdTypeLabel.alpha = 0.0
//    }, completion: {
//    (finished: Bool) -> Void in
//    
//    //Once the label is completely invisible, set the text and fade it back in
//    self.birdTypeLabel.text = "Bird Type: Swift"
//    
//    // Fade in
//    UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
//    self.birdTypeLabel.alpha = 1.0
//    }, completion: nil)
//    })
//}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
