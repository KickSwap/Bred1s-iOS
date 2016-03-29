//
//  ThemesTableViewCell.swift
//  KickSwap
//
//  Created by Brandon Sanchez on 3/24/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Material
import IBAnimatable

class ThemesTableViewCell: MaterialTableViewCell {

    
    @IBOutlet var cellBackgroundImage: UIImageView!
    @IBOutlet var themesLabel: UILabel!
    @IBOutlet var checkmark: AnimatableImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkmark.alpha = 0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
