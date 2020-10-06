//
//  BookingCell.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/16/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class BookingCell: UITableViewCell {

    @IBOutlet weak var edalImageView: UIImageView!
    @IBOutlet weak var edalTitleLabel: UILabel!
    @IBOutlet weak var edalSubTitleLabel: UILabel!
    @IBOutlet weak var edalPriceLabel: UILabel!
    @IBOutlet weak var edalTimeLabel: UILabel!
    @IBOutlet weak var edalDateLabel: UILabel!
    @IBOutlet weak var edalStatusLabel: UILabel!
    @IBOutlet weak var edalDemandeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
