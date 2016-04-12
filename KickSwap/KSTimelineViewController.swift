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
import PagingMenuController
import AFNetworking
import Firebase
import LiquidLoader
import Crashlytics
import ASValueTrackingSlider
import LTMorphingLabel
import DynamicBlurView

class KSTimelineViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, TextDelegate, TextViewDelegate, PagingMenuControllerDelegate {

   // @IBOutlet var timelineBackground: AnimatableImageView!
    @IBOutlet weak var timelineBackground: AnimatableImageView!

    @IBOutlet var timelineColorBackground: UIView!
   // @IBOutlet var timeline: UICollectionView!
    @IBOutlet weak var timeline: UICollectionView!

   // @IBOutlet var userProfileImage: UIImageView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet var profileTrayView: CardView!
    @IBOutlet var trayViewButton: UIButton!
    @IBOutlet var profileName: UILabel!
    
    
    @IBOutlet var nameBlurView: UIView!
    @IBOutlet var shoeTagView: UIVisualEffectView!
    @IBOutlet var shoeNameLabel: AnimatableLabel!
    @IBOutlet var shoeSizeLabel: AnimatableLabel!
    @IBOutlet var shoeConditionLabel: AnimatableLabel!
    
//    //Variables to pass to DetailViewController
//    var shoeImage: UIImage!
//    var shoeName: UILabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
//    var shoeCondition: UILabel!
//    var shoeSize: UILabel!


    var mainCollectionViewCellIndexPath: NSIndexPath?

    var trayOriginalCenter: CGPoint!
    var tapCount = 0

    var shoeTimeline: [Shoe]?
    var allUsers: [User]?
    let backgroundImages = [UIImage(named:"blackBox"),UIImage(named:"boxStack"),UIImage(named:"greenBox")]
    var pictureIndex:Int?
    var visibleUser: User?
    var bidValue: Float?

    let cardView: CardView = CardView()

    var detailViewController2: UIViewController?
    let detailViewController3 = DetailViewController()
    var animateChart: Bool?
    var doneLoading: Bool = false
    var loader: LiquidLoader!
    var delay = 0.0


    /// A Text storage object that monitors the changes within the textView.
    lazy var text: Text = Text()

    /// A TextView UI Component.
    var textView: TextView!



    override func viewDidLoad() {
        super.viewDidLoad()
        liquidLoader()
        alpha0()
        hideTrayView()
        hideNameView()
        animateChart = true
        getShoesFromFirebase()
        prefersStatusBarHidden()
        timeline.dataSource = self
        timeline.delegate = self
        
        self.profileTrayView.translatesAutoresizingMaskIntoConstraints = false
        //prepareView()
        //prepareTextView()
        //addToolBar(textView)
        //instantiateMenuController()
    
        //set image initially
        pictureIndex = 0
        timelineBackground.image = backgroundImages[pictureIndex!]

        //start timer
        var timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(KSTimelineViewController.loadImage), userInfo: nil, repeats: true)

    }

    func loadImage(){
        //setImage2
        var newIndex = pictureIndex! + 1
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

    func liquidLoader() {
        let circleFrame = CGRectMake(0, 0, 150, 150)
        loader = LiquidLoader(frame: circleFrame, effect: .GrowCircle(menuButtonsColor!))
        loader.center = self.view.center
        view.addSubview(loader)
        loader!.show()
    }

    func checkLoader() {
        if doneLoading == true {
            UIView.animateWithDuration(0.5, delay: 0, options: [], animations: {
                self.loader.alpha = 0
                }, completion: { (Bool) in
                    self.loader!.hide()
                    UIView.animateWithDuration(0.5, delay: 0, options: [], animations: {
                        self.alpha1()
                        self.animateTrayView()
                        self.delay = 0.0
                        self.animateNameView()
                    }, completion: { (Bool) in
                })
            })

        } else {
            loader!.show()
        }

    }

//Set Alphas for Animation
    func alpha0() {
        self.timeline.alpha = 0
        self.profileName.alpha = 0
        self.userProfileImage.alpha = 0
        //self.profileTrayView.alpha = 0
        //self.hideTrayView()
        //self.shoeTagView.alpha = 0
    }

    func alpha1() {
        self.timeline.alpha = 1
        self.profileName.alpha = 1
        self.userProfileImage.alpha = 1
        self.profileTrayView.alpha = 1
        //self.shoeTagView.alpha = 1
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        Style.loadTheme()
        layoutTheme()

        hideTrayView()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // set initial tray view location
        //animateTrayView()
    }

//Tray View Animations

    func hideTrayView() {
        self.profileTrayView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(profileTrayView.superview!).offset((profileTrayView.superview?.frame.height)!)
        }
    }

    func animateTrayView() {
        self.profileTrayView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo((profileTrayView.superview?.frame.height)! * 0.82).constraint
        }
        profileTrayView.setNeedsLayout()
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
            self.profileTrayView.layoutIfNeeded()
        }) { (Bool) in
        }
    }
    
    func hideNameView() {
        self.nameBlurView.alpha = 0
        self.nameBlurView.snp_makeConstraints { (make) in
            //make.bottom.equalTo((self.timeline.snp_bottom)).constraint
            make.bottom.equalTo((nameBlurView.superview?.centerYAnchor)!).constraint
            //make.centerY.equalTo(self.view.center).constraint
        }
    }
    
    func animateHideNameView() {
        self.nameBlurView.snp_remakeConstraints { (make) in
            //make.bottom.equalTo((self.timeline.snp_bottom)).constraint
            make.bottom.equalTo((nameBlurView.superview?.centerYAnchor)!).constraint
            //make.bottom.equalTo(self.timeline.topAnchor).constraint
        }
        //self.nameBlurView.alpha = 0
        nameBlurView.setNeedsLayout()
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.nameBlurView.alpha = 0
            self.nameBlurView.layoutIfNeeded()
        }) { (Bool) in
        }
    }
    
    func animateNameView() {
        
        self.nameBlurView.snp_remakeConstraints { (make) in
            make.top.equalTo((nameBlurView.superview?.topAnchor)!).offset(76).constraint
            //make.bottom.equalTo(self.timeline.snp_top).constraint
        }
        nameBlurView.backgroundColor = MaterialColor.white
        nameBlurView.setNeedsLayout()
        UIView.animateWithDuration(1, delay: self.delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            
            self.nameBlurView.alpha = 0.3
            self.nameBlurView.layoutIfNeeded()
            
        }) { (Bool) in
            self.delay = 0.3
        }
    }

//Instantiate Menu Controller

    func instantiateMenuController() {
        //Instantiate pages for container view
        let profileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("KSProfileViewController") as! KSProfileViewController
        profileViewController.profileUser = visibleUser
        profileViewController.getShoes()
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        profileViewController.title = "Profile"
        detailViewController.title = "Details"

        let viewControllers = [detailViewController, profileViewController]

        //instantiate PagingMenuController and customization
        //self.addChildViewController(detailViewController)
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController



        let options = PagingMenuOptions()
        options.defaultPage = 0
        options.backgroundColor = pagingMenuBackgroundColor!
        options.selectedBackgroundColor = pagingMenuSelectedBackgroundColor!
        options.textColor = pagingMenuTextColor!
        options.selectedTextColor = pagingMenuSelectedTextColor!
        options.menuHeight = 25
        options.font = RobotoFont.regular
        options.selectedFont = RobotoFont.bold
        options.menuItemMode = .Underline(height: 3, color: pagingMenuUnderlineColor!, horizontalPadding: 0, verticalPadding: 0)
        //options.menuPosition = .Bottom
        pagingMenuController.delegate = self
        options.menuDisplayMode = .SegmentedControl
        //(widthMode: .Flexible, centerItem: true, scrollingMode: .PagingEnabled)
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        print(pagingMenuController.childViewControllers)
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
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(KSTimelineViewController.discoverPressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(KSTimelineViewController.cancelPressed))
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
                tapCount += 1
                profileTrayView.setNeedsLayout()
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options:[] , animations: { () -> Void in
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
                //textView.userInteractionEnabled = false
                //textView.hidden = true
                tapCount += 1
                profileTrayView.setNeedsLayout()
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options:[] , animations: { () -> Void in
                    //self.trayView.center = self.trayUp
                    self.profileTrayView.layoutIfNeeded()
                    }, completion: { (Bool) -> Void in
                })
            }
        }


    }

    @IBAction func onTapTrayViewButton(sender: AnyObject) {

        tapCount += 1
        //print(tapCount)
        if tapCount % 2 == 0 {
            self.profileTrayView.snp_remakeConstraints { (make) -> Void in
                make.top.equalTo((profileTrayView.superview?.frame.height)! * 0.82).constraint
            }
            //ignoreView.userInteractionEnabled = false
            //ignoreView.hidden = true
            profileTrayView.setNeedsLayout()
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options:[] , animations: { () -> Void in
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
            //textView.userInteractionEnabled = false
            //textView.hidden = true
            profileTrayView.setNeedsLayout()
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2, options:[] , animations: { () -> Void in
                //self.trayView.center = self.trayDown
                self.profileTrayView.layoutIfNeeded()
                }, completion: { (Bool) -> Void in
            })
        }

    }

    func addBidView() {

        // Title label.
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "How Much?"
        titleLabel.textColor = MaterialColor.blue.darken1
        titleLabel.font = RobotoFont.mediumWithSize(20)
        cardView.titleLabel = titleLabel

        // Detail label.
        let shoeValueSlider: ASValueTrackingSlider = ASValueTrackingSlider()
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        shoeValueSlider.numberFormatter = formatter
        //print(self.shoeTimeline![mainCollectionViewCellIndexPath!.row].price)
        if let indexPath = mainCollectionViewCellIndexPath?.row  {
            shoeValueSlider.minimumValue = Float(self.shoeTimeline![indexPath].price!)! - 10
            shoeValueSlider.maximumValue = Float(self.shoeTimeline![indexPath].price!)! + 100
            shoeValueSlider.addTarget(self, action: "bidSliderDidChange:", forControlEvents:UIControlEvents.ValueChanged)
            cardView.detailView = shoeValueSlider
        } else {
                shoeValueSlider.minimumValue = Float(self.shoeTimeline![0].price!)! - 10
                shoeValueSlider.maximumValue = Float(self.shoeTimeline![0].price!)! + 100
                shoeValueSlider.addTarget(self, action: "bidSliderDidChange:", forControlEvents:UIControlEvents.ValueChanged)
                cardView.detailView = shoeValueSlider
                self.mainCollectionViewCellIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        }
        
        


        // Yes button.
        let btn1: FlatButton = FlatButton()
        btn1.pulseColor = MaterialColor.blue.lighten1
        btn1.pulseScale = false
        btn1.setTitle("Submit", forState: .Normal)
        btn1.setTitleColor(MaterialColor.blue.darken1, forState: .Normal)
        btn1.addTarget(self, action: "submitBid:", forControlEvents: UIControlEvents.TouchUpInside)

        // No button.
        let btn2: FlatButton = FlatButton()
        btn2.pulseColor = MaterialColor.blue.lighten1
        btn2.pulseScale = false
        btn2.setTitle("Cancel", forState: .Normal)
        btn2.setTitleColor(MaterialColor.blue.darken1, forState: .Normal)
        btn2.addTarget(self, action: "cancelBid:", forControlEvents: UIControlEvents.TouchUpInside)

        // Add buttons to left side.
        cardView.rightButtons = [btn1, btn2]

        // To support orientation changes, use MaterialLayout.
        view.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        MaterialLayout.alignFromTop(view, child: cardView, top: self.view.center.y - (cardView.height/2))
        MaterialLayout.alignToParentHorizontally(view, child: cardView, left: 20, right: 20)
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

    func items() {

    }

    // Instantiate DetailViewController
    func detailViewController() -> DetailViewController {
        //print(self.childViewControllers)
        let pagingmenucontroller = self.childViewControllers[0] as! PagingMenuController
        //print(pagingmenucontroller.childViewControllers)
        //print(pagingmenucontroller.childViewControllers[0])
        return pagingmenucontroller.childViewControllers[0] as! DetailViewController
    }


//CollectionView Delegate Functions

    func collectionView(timeline: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = timeline.dequeueReusableCellWithReuseIdentifier("TimelineCell", forIndexPath: indexPath) as! KSTimelineCollectionViewCell
        
        cell.shoeImageView.image = shoeTimeline![indexPath.row].shoeImage
        
        return cell
    }

    func collectionView(timeline: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        tapCount += 1
        self.profileTrayView.snp_remakeConstraints { (make) -> Void in
            make.top.equalTo((profileTrayView.superview?.snp_top)!).offset(0).constraint
        }
        //textView.userInteractionEnabled = false
        //textView.hidden = true
        profileTrayView.setNeedsLayout()
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.5, options:[] , animations: { () -> Void in
            self.profileTrayView.layoutIfNeeded()
            }, completion: { (Bool) -> Void in
        })
    }

//MARK: - Firebase Get Methods
    func getShoesFromFirebase() {
        // Get a reference to our posts
        FirebaseClient.sharedClient.getTimelineShoes({ (shoes, error) in
            if error == nil {
                self.doneLoading = true // start animation
                self.checkLoader() // start animation
                self.shoeTimeline = shoes as! [Shoe]
                self.getUserById(self.shoeTimeline![0].ownerId!)
                self.layoutTagView()
                self.timeline.reloadData()
            } else {
                print("Error: KSTimelineViewController.getShoes")
                self.loader.show()
            }
        })

    }
    
    func layoutTagView() {
        self.shoeNameLabel.text = shoeTimeline![0].name
        self.shoeSizeLabel.text = shoeTimeline![0].size!
        self.shoeConditionLabel.text = shoeTimeline![0].condition
        //self.shoeTagView.backgroundColor = UIColor.clearColor()//shoeTagViewColor
    }

    func getUserById(userId: String) {
        FirebaseClient.sharedClient.getUserById(userId) { (user, error) in
            if(error == nil){ //good tings..
                self.visibleUser = user
                self.userProfileImage.setImageWithURL(NSURL(string: (self.visibleUser?.profilePicUrl)!)!)
                self.userProfileImage.clipsToBounds = true
                self.profileName.text = self.visibleUser?.displayName
                self.userProfileImage.setImageWithURL(NSURL(string: (self.visibleUser?.profilePicUrl)!)!)
                self.userProfileImage.clipsToBounds = true
                self.profileName.text = self.visibleUser?.displayName
                self.instantiateMenuController()
                self.detailViewController() // must be called after instantiateMenuController so view can load
                self.detailViewController().loadPage()
            } else { //bad ting dat :(

            }
        }

    }

// ProfileTrayView Animations

    func flipDown() {
        let transitionOptions: UIViewAnimationOptions = [.TransitionFlipFromBottom, .CurveEaseIn, .ShowHideTransitionViews]

        UIView.transitionWithView(profileTrayView, duration: 1, options: transitionOptions, animations: {
            //self.profileTrayView = self.profileTrayView
            //self.animateHideNameView()
            self.hideLabels()
            self.profileTrayView.hidden = true
        }) { (Bool) in
        }
    }

    func flipUp() {
        let transitionOptions: UIViewAnimationOptions = [.TransitionFlipFromTop, .ShowHideTransitionViews]
        self.animateLabels()
        UIView.transitionWithView(profileTrayView, duration: 1, options: transitionOptions, animations: {
            //self.animateNameView()
            
            self.profileTrayView.hidden = false
        }) { (Bool) in
        }
        
        
    }

// ScrollView Delegate Functions

    func scrollViewDidScroll(scrollView: UIScrollView) {
    }

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //animate profileTrayView
        flipDown()
    }

    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {

        // Restart trayview chart animation and scroll view position
        instantiateMenuController()
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var currentCellCenter = CGPointMake(self.timeline.center.x + self.timeline.contentOffset.x,
            self.timeline.center.y + self.timeline.contentOffset.y)

        self.mainCollectionViewCellIndexPath = self.timeline.indexPathForItemAtPoint(currentCellCenter)

        print(self.shoeTimeline![mainCollectionViewCellIndexPath!.row].price)

        if(self.mainCollectionViewCellIndexPath != nil){
            self.shoeNameLabel.text = shoeTimeline![mainCollectionViewCellIndexPath!.row].name
            self.shoeSizeLabel.text = shoeTimeline![mainCollectionViewCellIndexPath!.row].size!
            self.shoeConditionLabel.text = shoeTimeline![mainCollectionViewCellIndexPath!.row].condition
            //self.shoeTagView.backgroundColor = UIColor.clearColor()//shoeTagViewColor
            getUserById(shoeTimeline![(mainCollectionViewCellIndexPath?.row)!].ownerId!)
            flipUp()
            //animateNameView()
        }
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        var currentCellCenter = CGPointMake(self.timeline.center.x + self.timeline.contentOffset.x,
                                            self.timeline.center.y + self.timeline.contentOffset.y)
        self.mainCollectionViewCellIndexPath = self.timeline.indexPathForItemAtPoint(currentCellCenter)
        
        
        if(self.mainCollectionViewCellIndexPath != nil){ //save from middle not being referenced
            if(decelerate) {//user scrolling fast
                //getUserById(shoeTimeline![(mainCollectionViewCellIndexPath?.row)!].ownerId!)
                
            } else { //user just dragging
                //flipUp()
            }
            
        }
    }

    //MARK: Themes Class - Init
    func layoutTheme() {
        self.timelineColorBackground.backgroundColor = timelineBackgroundColor
        self.profileTrayView.backgroundColor = profileTrayViewColor
        self.profileTrayView.pulseColor = pulseColor
        //self.shoeTagView.layer.cornerRadius = 10
        //nameBlurView.layer.cornerRadius = 10
        nameBlurView.backgroundColor = MaterialColor.white
        nameBlurView.alpha = 0.3
//        nameBlurView.blurRadius = 60
//        nameBlurView.blurRatio = 0.1
//        nameBlurView.blendColor = profileTrayViewColor
        
//        shoeNameLabel.morphingEffect = .Evaporate
//        shoeConditionLabel.morphingEffect = .Evaporate
//        shoeSizeLabel.morphingEffect = .Evaporate
        shoeNameLabel.textColor = MaterialColor.white
        shoeConditionLabel.textColor = MaterialColor.white
        shoeSizeLabel.textColor = MaterialColor.white
        shoeNameLabel.font = RobotoFont.boldWithSize(18)
        shoeConditionLabel.font = RobotoFont.boldWithSize(14)
        shoeSizeLabel.font = RobotoFont.boldWithSize(22)
        //trayViewButton.setBackgroundImage(UIImage(named: ""), forState: .Normal)
        //trayViewButton.setBackgroundImage(UIImage(named: ""), forState: .Highlighted)
        profileName.textColor = textColor
    }
    
    func addBlurViews() {
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.shoeNameLabel.bounds
        //shoeNameLabel.addSubview(blurEffectView)
    }


    @IBAction func bidButtonPressed(sender: AnyObject) {
        print("bid")
        addBidView()
    }

    func cancelBid(sender:UIButton!) {
        cardView.removeFromSuperview()
    }

    func submitBid(sender:UIButton!) {
        print(bidValue)
        let currentBid = Bid(user: User.currentUser!, price: bidValue!) //form bid object
        let shoeToBidOn = shoeTimeline![mainCollectionViewCellIndexPath!.row] //get shoe we are bidding on
//        var tempBidArray = shoeTimeline![mainCollectionViewCellIndexPath!.row].bids
//        tempBidArray?.append("\(bidValue)")
//        shoeTimeline![mainCollectionViewCellIndexPath!.row].bids = tempBidArray
//        print(shoeTimeline![mainCollectionViewCellIndexPath!.row].bids)
        FirebaseClient.sharedClient.addBid(shoeToBidOn, bid: currentBid)
        cardView.removeFromSuperview()
    }

    func bidSliderDidChange(sender: UISlider) {
//        sender.setValue(ceil(((sender.value + 2.5) / 5) * 5), animated: false)
        sender.value = ceil(sender.value)
        bidValue = ceil(sender.value)
    }
    
    func animateLabels() {
        self.shoeNameLabel.alpha = 1
        self.shoeConditionLabel.alpha = 1
        self.shoeSizeLabel.alpha = 1
        //shoeNameLabel.animationType = "squeezeInLeft"
        shoeNameLabel.delay = 0.5
        shoeNameLabel.force = 0.5
        shoeNameLabel.velocity = 0.5
        shoeNameLabel.damping = 1
        shoeSizeLabel.delay = 0.5
        shoeSizeLabel.force = 0.5
        shoeSizeLabel.velocity = 0.5
        shoeSizeLabel.damping = 1
        shoeConditionLabel.delay = 0.5
        shoeConditionLabel.force = 0.5
        shoeConditionLabel.velocity = 0.5
        shoeConditionLabel.damping = 1
        shoeNameLabel.squeezeInLeft()
        shoeConditionLabel.squeezeInLeft()
        shoeSizeLabel.squeezeInLeft()
    }
    
    func hideLabels() {
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            self.shoeNameLabel.alpha = 0
            self.shoeConditionLabel.alpha = 0
            self.shoeSizeLabel.alpha = 0
            }, completion: { (Bool) in
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

extension Array {
    func ref (i:Int) -> Element? {
        return 0 <= i && i < count ? self[i] : nil
    }
}
