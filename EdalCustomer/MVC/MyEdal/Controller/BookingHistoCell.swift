//
//  BookingHistoryCell.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 9/10/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class BookingHistoryCell: UITableViewCell {
    @IBOutlet weak var dealImage: UIImageView!
    @IBOutlet weak var dealTitleLabel: UILabel!
    @IBOutlet weak var dealCategoryLabel: UILabel!
    @IBOutlet weak var dealDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dealTimeLabel: UILabel!
    @IBOutlet weak var dealStatusTitleLabel: UILabel!
    @IBOutlet weak var dealStatusValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
