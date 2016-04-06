//
//  KSNotificationTableViewCell.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 3/21/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class KSNotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    var notification: Notification!{
        didSet{
            ownerLabel.text = notification.ownerId
            messageLabel.text = notification.message
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}