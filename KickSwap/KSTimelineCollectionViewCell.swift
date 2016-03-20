//
//  KSTimelineCollectionViewCell.swift
//  KickSwap
//
//  Created by Brandon Sanchez on 2/23/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import ChameleonFramework
import Material

class KSTimelineCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet var shoeTagView: UIView!
    @IBOutlet var shoeImageView: UIImageView!
    @IBOutlet var shoeNameLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var conditionLabel: UILabel!


    
    override func awakeFromNib() {
        //backgroundColorView.backgroundColor = UIColor(hexString: "FA4A07")
        shoeImageView.image = UIImage(named: "blackYeezy")
        shoeImageView.clipsToBounds = true
        shoeNameLabel.textColor = UIColor.flatWhiteColor()
        conditionLabel.textColor = UIColor.flatWhiteColor()
        sizeLabel.textColor = MaterialColor.white
        shoeNameLabel.font = RobotoFont.boldWithSize(18)
        conditionLabel.font = RobotoFont.boldWithSize(14)
        sizeLabel.font = RobotoFont.boldWithSize(22)
    }
}
