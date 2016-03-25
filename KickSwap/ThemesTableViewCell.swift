//
//  ThemesTableViewCell.swift
//  KickSwap
//
//  Created by Brandon Sanchez on 3/24/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit

class ThemesTableViewCell: UITableViewCell {

    
    @IBOutlet var cellBackgroundImage: UIImageView!
    @IBOutlet var themesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
