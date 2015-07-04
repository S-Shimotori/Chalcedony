//
//  CCDDataListTableViewCell.swift
//  Chalcedony
//
//  Created by S-Shimotori on 7/3/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class CCDDataListTableViewCell: UITableViewCell {

    @IBOutlet weak var labelToShowLaboinDate: UILabel!
    @IBOutlet weak var labelToShowLaboridaDate: UILabel!
    @IBOutlet weak var labelToShowHowLongStayLabo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
