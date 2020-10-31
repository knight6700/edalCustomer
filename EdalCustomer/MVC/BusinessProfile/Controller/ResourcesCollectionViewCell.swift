//
//  resourcesCollectionViewCell.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/9/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class ResourcesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var resourcesImageView: UIImageView!
    @IBOutlet weak var resourcesNameLabel: UILabel!
    @IBOutlet weak var resourcesTitleLabel: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupSelectView(selected: Bool)  {
        if selected {
            resourcesImageView.setRounded()
        }else {
            contentView.cornerRadius = 0
            contentView.borderColor = .white
            contentView.borderWidth = 0
            contentView.layer.masksToBounds = false
            unRounded()
        }
    }
    
    private func unRounded() {
        resourcesImageView.layer.cornerRadius = 0
        resourcesImageView.layer.borderWidth = 0
        resourcesImageView.layer.borderColor = UIColor.clear.cgColor
    }
    
    
}
