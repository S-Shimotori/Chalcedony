//
//  CCDSwitchTableViewCell.swift
//  Chalcedony
//
//  Created by S-Shimotori on 6/20/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class CCDSwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var switchToSetting: UISwitch!
    @IBOutlet weak var labelToSetting: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
