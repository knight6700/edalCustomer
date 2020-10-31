//
//  MyDealsTableViewCell.swift
//  EdalCustomer
//
//  Created by Mahmoud Fares on 10/9/20.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit

class MyDealsTableViewCell: UITableViewCell {
    @IBOutlet weak var dealImage: UIImageView!
    @IBOutlet weak var dealTitleLabel: UILabel!
    @IBOutlet weak var dealCategoryLabel: UILabel!
    @IBOutlet weak var dealDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dealTimeLabel: UILabel!
    @IBOutlet weak var dealStatusTitleLabel: UILabel!
    @IBOutlet weak var dealStatusValueLabel: UILabel!
    @IBOutlet weak var contentainrView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentainrView.layer.shadowColor = #colorLiteral(red: 0.517593801, green: 0.5176843405, blue: 0.5175818801, alpha: 0.3550851004)
        contentainrView.layer.shadowOpacity = 1
        contentainrView.layer.shadowOffset = .zero
        contentainrView.layer.shadowRadius = 10

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setStatusColor(id: Int) {
        switch id {
            case 1:
                dealStatusValueLabel.textColor = .yellow
            case  2:
                break
            case 3:
                dealStatusValueLabel.textColor = .green
            case 4:
                dealStatusValueLabel.textColor = #colorLiteral(red: 0.3541823626, green: 0.6177722812, blue: 0.9613298774, alpha: 1)
            case 5:
                dealStatusTitleLabel.textColor = .orange
            case 6:
                dealStatusTitleLabel.textColor = .green
            case 7:
                dealStatusTitleLabel.textColor = .red
            case 8:
                dealStatusTitleLabel.textColor = .red
            default:
                dealStatusTitleLabel.textColor = .black
        }
    }
}
