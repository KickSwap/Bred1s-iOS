//
//  KSVoteTableViewCell.swift
//  KickSwap
//
//  Created by Hugh A. Miles II on 3/16/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class KSVoteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var shoeImageView: UIImageView!
    @IBOutlet weak var shoeNameLabel: UILabel!
    @IBOutlet weak var shoePriceLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    var shoe:Release! {
        didSet{
            //shoeNameLabel.text = shoe.sneakerName
            //shoePriceLabel.text = shoe.price
            shoeImageView.setImageWithURL(shoe.imageURL!)
            shoeNameLabel.text = shoe.sneakerName
            shoePriceLabel.text = shoe.price
            colorLabel.text = shoe.color
            print(shoe.releaseDay)
            monthLabel.text = shoe.releaseMonth
            dayLabel.text = shoe.releaseDay
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerImageView.layer.masksToBounds = false
        bannerImageView.layer.shadowColor = UIColor.blackColor().CGColor
        bannerImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bannerImageView.layer.shadowRadius = 2.0
        bannerImageView.layer.shadowOpacity = 0.5
    }

        // Configure the view for the selected state
}


