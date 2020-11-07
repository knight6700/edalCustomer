//
//  LoadingTableViewCell.swift
//  EdalCustomer
//
//  Created by Mahmoud Fares on 10/10/20.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        loadingIndicator.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
