//
//  SerivcesProductCell.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/5/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class SerivcesProductCell: UITableViewCell {

    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var servicesTitle: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bookRequestButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
