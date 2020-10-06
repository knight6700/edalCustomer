//
//  ResourceCollectionViewCell.swift
//  edal-IosCustomerApp
//
//  Created by Mahmoud Maamoun on 1/19/20.
//  Copyright © 2020 hesham ghalaab. All rights reserved.
//

import UIKit

class ResourceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var resourceImage: RoundedImageView!
    @IBOutlet weak var resourceName: UILabel!
    
    func selectResource() {
        self.resourceImage.setRounded()
    }
}
