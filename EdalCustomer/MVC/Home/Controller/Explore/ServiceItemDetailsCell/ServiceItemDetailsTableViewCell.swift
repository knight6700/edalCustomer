//
//  ServiceItemDetailsTableViewCell.swift
//  EdalCustomer
//
//  Created by Mahmoud Fares on 10/7/20.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit
protocol ServiceItemDetailsDelegate: class {
    func bookService(cell: UITableViewCell)
}
class ServiceItemDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var serviceDescriptionLabel: UILabel!
    
    weak var delegate: ServiceItemDetailsDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func bookPressed(_ sender: Any) {
        delegate?.bookService(cell: self)
    }
    
}
