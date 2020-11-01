//
//  ComplaintsCell.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 9/11/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class ComplaintsCell: UITableViewCell {
    @IBOutlet weak var complaintImage: UIImageView!
    @IBOutlet weak var surviceNameLabel: UILabel!
    @IBOutlet weak var resourceNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusTitleLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        complaintImage.setRounded(color: .gray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
      func setStatusColor(id: Int) {
        switch id {
            case 1:
                statusValueLabel.textColor = .yellow
            case  2:
                break
            case 3:
                statusValueLabel.textColor = .green
            case 4:
                statusValueLabel.textColor = #colorLiteral(red: 0.3541823626, green: 0.6177722812, blue: 0.9613298774, alpha: 1)
            case 5:
                statusValueLabel.textColor = .orange
            case 6:
                statusValueLabel.textColor = .green
            case 7:
                statusValueLabel.textColor = .red
            case 8:
                statusValueLabel.textColor = .red
            default:
                statusValueLabel.textColor = .black
        }
    }

    
}
