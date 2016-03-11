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

class KSConfirmViewController: UIViewController, MaterialSwitchDelegate {
    
    var imageToPost: UIImage?
    var shoeCondition: String?
    
    let conditionDropDown = DropDown()
    let sizeDropDown = DropDown()
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        let closeButton: FlatButton = FlatButton(frame: CGRectMake(12, 30, 30, 30))
        closeButton.setImage(UIImage(named: "ic_close_black"), forState: .Normal)
        closeButton.addTarget(self, action: "closePost", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(closeButton)
        
        
        let bidLabel: MaterialLabel = MaterialLabel(frame: CGRectMake(12, 100, 135, 24))
        bidLabel.font = RobotoFont.regularWithSize(18)
        bidLabel.textColor = MaterialColor.black
        bidLabel.text = "Set Starting Bid"
        
        view.addSubview(bidLabel)

        let bidField: TextField = TextField(frame: CGRectMake(270, 100, 75, 24))
        bidField.placeholder = "Bid"
        bidField.placeholderTextColor = MaterialColor.grey.base
        bidField.font = RobotoFont.regularWithSize(16)
        bidField.textColor = MaterialColor.black
        bidField.keyboardType = UIKeyboardType.DecimalPad
        
        bidField.titleLabel = UILabel()
        bidField.titleLabel!.font = RobotoFont.mediumWithSize(12)
        bidField.titleLabelColor = MaterialColor.grey.base
        bidField.titleLabelActiveColor = MaterialColor.blue.accent3
        
        let image = UIImage(named: "ic_close")?.imageWithRenderingMode(.AlwaysTemplate)
        
        let clearButton: FlatButton = FlatButton()
        clearButton.pulseColor = MaterialColor.grey.base
        clearButton.pulseScale = false
        clearButton.tintColor = MaterialColor.grey.base
        clearButton.setImage(image, forState: .Normal)
        clearButton.setImage(image, forState: .Highlighted)
        
        bidField.clearButton = clearButton
        
        view.addSubview(bidField)
        
        let conditionLabel: MaterialLabel = MaterialLabel(frame: CGRectMake(12, 155, 100, 24))
        conditionLabel.font = RobotoFont.regularWithSize(18)
        conditionLabel.textColor = MaterialColor.black
        conditionLabel.text = "Condition"
        
        view.addSubview(conditionLabel)
        
        let conditionButton: FlatButton = FlatButton(frame: CGRectMake(245, 150, 100, 38))
        conditionButton.contentHorizontalAlignment = .Left
        conditionButton.setTitleColor(MaterialColor.black, forState: .Normal)
        conditionButton.titleLabel?.font = RobotoFont.regularWithSize(16)
        conditionButton.setTitle("DS", forState: .Normal)
        conditionButton.setBackgroundImage(UIImage(named: "dropdown_menu"), forState: .Normal)
        conditionButton.addTarget(self, action: "showOrDismissConditions:", forControlEvents: UIControlEvents.TouchUpInside)
        
        conditionDropDown.anchorView = conditionButton
        conditionDropDown.direction = .Bottom
        conditionDropDown.width = 100
        conditionDropDown.dataSource = ["DS", "VNDS", "Used"]
        conditionDropDown.selectionAction = { [unowned self] (index, item) in
            conditionButton.setTitle(item, forState: .Normal)
        }
        conditionDropDown.dismissMode = .Automatic
        conditionDropDown.bottomOffset = CGPoint(x: 0, y:conditionButton.bounds.height)
        
        DropDown.appearance().textColor = MaterialColor.black
        DropDown.appearance().textFont = RobotoFont.regularWithSize(16)
        //DropDown.appearance().backgroundColor = MaterialColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGrayColor()
        
        view.addSubview(conditionButton)
        
        let sizeLabel: MaterialLabel = MaterialLabel(frame: CGRectMake(12, 210, 135, 24))
        sizeLabel.font = RobotoFont.regularWithSize(18)
        sizeLabel.textColor = MaterialColor.black
        sizeLabel.text = "Size (US)"
        
        view.addSubview(sizeLabel)
        
        let sizeButton: FlatButton = FlatButton(frame: CGRectMake(245, 205, 100, 38))
        sizeButton.contentHorizontalAlignment = .Left
        sizeButton.setTitleColor(MaterialColor.black, forState: .Normal)
        sizeButton.titleLabel?.font = RobotoFont.regularWithSize(16)
        sizeButton.setTitle("Size", forState: .Normal)
        sizeButton.setBackgroundImage(UIImage(named: "dropdown_menu"), forState: .Normal)
        sizeButton.addTarget(self, action: "showOrDismissSizes:", forControlEvents: UIControlEvents.TouchUpInside)
        
        sizeDropDown.anchorView = conditionButton
        sizeDropDown.direction = .Bottom
        sizeDropDown.width = 100
        sizeDropDown.dataSource = ["6", "6.5", "7", "7.5", "8", "8.5", "9", "9.5", "10", "10.5", "11", "11.5", "12", "12.5", "13", "13.5", "14", "14.5", "15"]
        sizeDropDown.selectionAction = { [unowned self] (index, item) in
            sizeButton.setTitle(item, forState: .Normal)
        }
        sizeDropDown.dismissMode = .Automatic
        sizeDropDown.bottomOffset = CGPoint(x: 0, y:sizeButton.bounds.height)
        
        view.addSubview(sizeButton)
        
        let boxLabel: MaterialLabel = MaterialLabel(frame: CGRectMake(12, 255, 135, 24))
        boxLabel.font = RobotoFont.regularWithSize(18)
        boxLabel.textColor = MaterialColor.black
        boxLabel.text = "Original Box?"
        
        view.addSubview(boxLabel)
        
        let boxSwitchView: MaterialView = MaterialView(frame: CGRectMake(280, 255, 50, 32))
        view.addSubview(boxSwitchView)
        
        let boxSwitch: MaterialSwitch = MaterialSwitch(state: .Off, style: .Default, size: .Default)
        boxSwitch.delegate = self
        boxSwitch.translatesAutoresizingMaskIntoConstraints = false
        boxSwitchView.addSubview(boxSwitch)
        
        MaterialLayout.alignToParentHorizontally(boxSwitchView, child: boxSwitch)
        MaterialLayout.alignToParentVertically(boxSwitchView, child: boxSwitch)
        
        let receiptLabel: MaterialLabel = MaterialLabel(frame: CGRectMake(12, 305, 135, 24))
        receiptLabel.font = RobotoFont.regularWithSize(18)
        receiptLabel.textColor = MaterialColor.black
        receiptLabel.text = "Reciept?"
        
        view.addSubview(receiptLabel)
        
        let receiptSwitchView: MaterialView = MaterialView(frame: CGRectMake(280, 305, 50, 32))
        view.addSubview(receiptSwitchView)
        
        let receiptSwitch: MaterialSwitch = MaterialSwitch(state: .Off, style: .Default, size: .Default)
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
    
//    func closePost() {
//        performSegueWithIdentifier("toProfi", sender: self)
//    }
    
    internal func materialSwitchStateChanged(control: MaterialSwitch) {
        print("MaterialSwitch - Style: \(control.switchStyle), Size: \(control.switchSize), State: \(control.switchState), On: \(control.on), Selected: \(control.selected),  Highlighted: \(control.highlighted)")
    }
    
    

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }


}
