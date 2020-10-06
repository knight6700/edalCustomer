//
//  MenuCell.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/5/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.alpha = 0.6
    }
    
    func setupCell(text: String) {
        titleLabel.text = text
    }
    
    override var isSelected: Bool {
        didSet{
            titleLabel.alpha = isSelected ? 1.0 : 0.6
        }
     }
}
