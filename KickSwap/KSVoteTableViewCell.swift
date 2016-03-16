//
//  KSVoteTableViewCell.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 3/16/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class KSVoteTableViewCell: UITableViewCell {

    @IBOutlet weak var shoeImageView: UIImageView!
    @IBOutlet weak var shoeNameLabel: UILabel!
    @IBOutlet weak var shoePriceLabel: UILabel!
    @IBOutlet weak var shoeReleaseDateLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func upVotePressed(sender: AnyObject) {
    }
    @IBAction func downVotePressed(sender: AnyObject) {
    }
}
