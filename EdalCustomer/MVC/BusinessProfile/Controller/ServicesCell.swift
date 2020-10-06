//
//  ServicesCell.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/17/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class ServicesCell: UITableViewCell {

    @IBOutlet weak var ServicesTitleLabel: UILabel!
    @IBOutlet weak var descriptionServicesLabel: UILabel!
    @IBOutlet weak var bookServicesButton: UIButton!
    @IBOutlet weak var priceServicesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
