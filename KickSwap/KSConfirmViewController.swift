//
//  KSConfirmViewController.swift
//  KickSwap
//
//  Created by Eric Suarez on 3/10/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Material
import DropDown
import Firebase

class KSConfirmViewController: UIViewController, MaterialSwitchDelegate {
    
    var imageToPost: UIImage?
    var shoeToPost: Shoe?
    
    let nameField = TextField()
    let bidField = TextField()
    let conditionButton = FlatButton()
    let sizeButton = FlatButton()
    var boxSwitch = MaterialSwitch()
    var receiptSwitch = MaterialSwitch()
    
    
    @IBOutlet weak var detailsScrollView: UIScrollView!
    
    
    let conditionDropDown = DropDown()
    let sizeDropDown = DropDown()
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewImageView.clipsToBounds = true
        detailsScrollView.contentSize = CGSize(width: detailsScrollView.frame.size.width, height: 375)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(KSConfirmViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let closeButton: FlatButton = FlatButton(frame: CGRectMake(12, 30, 60, 30))
        closeButton.setImage(UIImage(named: "ic_close_white"), forState: .Normal)
        closeButton.addTarget(self, action: #selector(KSConfirmViewController.closePost), forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(closeButton)
        
        let nameLabel: MaterialLabel = MaterialLabel(frame: CGRectMake(12, 25, 80, 24))
        nameLabel.font = RobotoFont.regularWithSize(18)
        nameLabel.textColor = MaterialColor.black
        nameLabel.text = "Name"
        
        detailsScrollView.addSubview(nameLabel)
        
        nameField.frame = CGRectMake(100, 25, 250, 24)
        nameField.placeholder = "Name"
        nameField.placeholderTextColor = MaterialColor.grey.base
        nameField.font = RobotoFont.regularWithSize(16)
        nameField.textColor = MaterialColor.black
        
        nameField.titleLabel = UILabel()
        nameField.titleLabel!.font = RobotoFont.mediumWithSize(12)
        nameField.titleLabelColor = MaterialColor.grey.base
        nameField.titleLabelActiveColor = MaterialColor.blue.accent3
        
        let image = UIImage(named: "ic_close")?.imageWithRenderingMode(.AlwaysTemplate)
        
        let clearButton: FlatButton = FlatButton()
        clearButton.pulseColor = MaterialColor.grey.base
        clearButton.pulseScale = false
        clearButton.tintColor = MaterialColor.grey.base
        clearButton.setImage(image, forState: .Normal)
        clearButton.setImage(image, forState: .Highlighted)
        
        nameField.clearButton = clearButton
        
        detailsScrollView.addSubview(nameField)
        
        let bidLabel: MaterialLabel = MaterialLabel(frame: CGRectMake(12, 85, 140, 24))
        bidLabel.font = RobotoFont.regularWithSize(18)
        bidLabel.textColor = MaterialColor.black
        bidLabel.text = "Set Starting Bid"
        
        detailsScrollView.addSubview(bidLabel)

        bidField.frame = CGRectMake(270, 85, 75, 24)
        bidField.placeholder = "Bid"
        bidField.placeholderTextColor = MaterialColor.grey.base
        bidField.font = RobotoFont.regularWithSize(16)
        bidField.textColor = MaterialColor.black
        bidField.keyboardType = UIKeyboardType.DecimalPad
        
        bidField.titleLabel = UILabel()
        bidField.titleLabel!.font = RobotoFont.mediumWithSize(12)
        bidField.titleLabelColor = MaterialColor.grey.base
        bidField.titleLabelActiveColor = MaterialColor.blue.accent3
        
        bidField.clearButton = clearButton
        
        detailsScrollView.addSubview(bidField)
        
        let conditionLabel: MaterialLabel = MaterialLabel(frame: CGRectMake(12, 145, 100, 24))
        conditionLabel.font = RobotoFont.regularWithSize(18)
        conditionLabel.textColor = MaterialColor.black
        conditionLabel.text = "Condition"
        
        detailsScrollView.addSubview(conditionLabel)
        
        conditionButton.frame = CGRectMake(245, 145, 100, 38)
        conditionButton.contentHorizontalAlignment = .Left
        conditionButton.setTitleColor(MaterialColor.black, forState: .Normal)
        conditionButton.titleLabel?.font = RobotoFont.regularWithSize(16)
        conditionButton.setTitle("DS", forState: .Normal)
        conditionButton.setBackgroundImage(UIImage(named: "dropdown_menu"), forState: .Normal)
        conditionButton.addTarget(self, action: #selector(KSConfirmViewController.showOrDismissConditions(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        conditionDropDown.anchorView = conditionButton
        conditionDropDown.direction = .Bottom
        conditionDropDown.width = 100
        conditionDropDown.dataSource = ["DS", "VNDS", "Used"]
        conditionDropDown.selectionAction = { [unowned self] (index, item) in
            self.conditionButton.setTitle(item, forState: .Normal)
        }
        conditionDropDown.dismissMode = .Automatic
        conditionDropDown.bottomOffset = CGPoint(x: 0, y:conditionButton.bounds.height)
        
        DropDown.appearance().textColor = MaterialColor.black
        DropDown.appearance().textFont = RobotoFont.regularWithSize(16)
        //DropDown.appearance().backgroundColor = MaterialColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGrayColor()
        
        detailsScrollView.addSubview(conditionButton)
        
        let sizeLabel: MaterialLabel = MaterialLabel(frame: CGRectMake(12, 205, 135, 24))
        sizeLabel.font = RobotoFont.regularWithSize(18)
        sizeLabel.textColor = MaterialColor.black
        sizeLabel.text = "Size (US)"
        
        detailsScrollView.addSubview(sizeLabel)
        
        sizeButton.frame = CGRectMake(245, 205, 100, 38)
        sizeButton.contentHorizontalAlignment = .Left
        sizeButton.setTitleColor(MaterialColor.black, forState: .Normal)
        sizeButton.titleLabel?.font = RobotoFont.regularWithSize(16)
        sizeButton.setTitle("Size", forState: .Normal)
        sizeButton.setBackgroundImage(UIImage(named: "dropdown_menu"), forState: .Normal)
        sizeButton.addTarget(self, action: #selector(KSConfirmViewController.showOrDismissSizes(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        sizeDropDown.anchorView = conditionButton
        sizeDropDown.direction = .Bottom
        sizeDropDown.width = 100
        sizeDropDown.dataSource = ["6", "6.5", "7", "7.5", "8", "8.5", "9", "9.5", "10", "10.5", "11", "11.5", "12", "12.5", "13", "13.5", "14", "14.5", "15"]
        sizeDropDown.selectionAction = { [unowned self] (index, item) in
            self.sizeButton.setTitle(item, forState: .Normal)
        }
        sizeDropDown.dismissMode = .Automatic
        sizeDropDown.bottomOffset = CGPoint(x: 0, y:sizeButton.bounds.height)
        
        detailsScrollView.addSubview(sizeButton)
        
        let boxLabel: MaterialLabel = MaterialLabel(frame: CGRectMake(12, 265, 135, 24))
        boxLabel.font = RobotoFont.regularWithSize(18)
        boxLabel.textColor = MaterialColor.black
        boxLabel.text = "Original Box?"
        
        detailsScrollView.addSubview(boxLabel)
        
        let boxSwitchView: MaterialView = MaterialView(frame: CGRectMake(280, 265, 50, 32))
        detailsScrollView.addSubview(boxSwitchView)
        
        boxSwitch = MaterialSwitch(state: .Off, style: .Default, size: .Default)
        boxSwitch.delegate = self
        boxSwitch.translatesAutoresizingMaskIntoConstraints = false
        boxSwitchView.addSubview(boxSwitch)
        
        MaterialLayout.alignToParentHorizontally(boxSwitchView, child: boxSwitch)
        MaterialLayout.alignToParentVertically(boxSwitchView, child: boxSwitch)
        
        let receiptLabel: MaterialLabel = MaterialLabel(frame: CGRectMake(12, 325, 135, 24))
        receiptLabel.font = RobotoFont.regularWithSize(18)
        receiptLabel.textColor = MaterialColor.black
        receiptLabel.text = "Reciept?"
        
        detailsScrollView.addSubview(receiptLabel)
        
        let receiptSwitchView: MaterialView = MaterialView(frame: CGRectMake(280, 325, 50, 32))
        detailsScrollView.addSubview(receiptSwitchView)
        
        receiptSwitch = MaterialSwitch(state: .Off, style: .Default, size: .Default)
        receiptSwitch.delegate = self
        receiptSwitch.translatesAutoresizingMaskIntoConstraints = false
        receiptSwitchView.addSubview(receiptSwitch)
        
        MaterialLayout.alignToParentHorizontally(receiptSwitchView, child: receiptSwitch)
        MaterialLayout.alignToParentVertically(receiptSwitchView, child: receiptSwitch)
        
        previewImageView.image = imageToPost
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields to resign the first responder status.
        view.endEditing(true)
    }
    
    func showOrDismissConditions(sender: FlatButton) {
        if conditionDropDown.hidden {
            conditionDropDown.show()
        } else {
            conditionDropDown.hide()
        }
    }
    
    func showOrDismissSizes(sender: FlatButton) {
        if sizeDropDown.hidden {
            sizeDropDown.show()
        } else {
            sizeDropDown.hide()
        }
    }
    
    func closePost() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    internal func materialSwitchStateChanged(control: MaterialSwitch) {
        print("MaterialSwitch - Style: \(control.switchStyle), Size: \(control.switchSize), State: \(control.switchState), On: \(control.on), Selected: \(control.selected),  Highlighted: \(control.highlighted)")
    }
    
    @IBAction func confirmPost(sender: AnyObject) {
        var postBox: Bool?
        var postReceipt: Bool?
        
        if boxSwitch.on == true {
            postBox = true
        } else {
            postBox = false
        }
        
        if receiptSwitch.on == true {
            postReceipt = true
        } else {
            postReceipt = false
        }
        
        let imageData: NSData = UIImageJPEGRepresentation(imageToPost!, 0.9)!
        let imageString: NSString = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        
//        let if bidField.text != nil {
//            
//        }
        
        //1 - Create Dictionary 
        let dataToPost: NSDictionary = [
            "name": nameField.text!,
            "price": bidField.text!,
            "condition": conditionButton.titleLabel!.text!,
            "size": sizeButton.titleLabel!.text!,
            "ownerId": User.currentUser!.uid!,
            "originalBox": "\(postBox!)",
            "receipt": "\(postReceipt!)",
            "imageString": "\(imageString)"
        ]
        
        /*
        
        Using Client >> what we should be aiming for
        
        let myShoe = Shoe(data: dataToPost)
        FirebaseClient.saveShoes(myShoe)
                shoeToPost?.name = nameField.text
                shoeToPost?.price = Double(bidField.text!)
                shoeToPost?.condition = conditionButton.titleLabel!.text
                shoeToPost?.size = Double(sizeButton.titleLabel!.text!)
                shoeToPost?.ownerId = User.currentUser!.uid
        
                if boxSwitch.on == true {
                    shoeToPost?.originalBox = true
                } else {
                    shoeToPost?.originalBox = false
                }
        
                if receiptSwitch.on == true {
                    shoeToPost?.receipt = true
                } else {
                    shoeToPost?.receipt = false
                }
        */
        
        //Excellent Pivot for Now
        print(dataToPost)
        confirmSaveShoe(dataToPost)
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func confirmSaveShoe(shoe: NSDictionary) {
        FirebaseClient.sharedClient.saveShoes(Shoe(data:shoe))
        //FirebaseClient.sharedClient.saveShoes()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    var votes = [];
//    votesRef.on('value', function(snapshot) {
//    snapshot.forEach(function(vote) {
//    votes.push({ ip: vote.key(), stars: vote.val() });
//    });
//    alert('There are '+votes.length+' votes');
//    })

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }


}
