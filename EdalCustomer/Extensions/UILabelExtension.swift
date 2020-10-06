//
//  UILabelExtension.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/2/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class UILabelPadding: UILabel {
    
    let padding = UIEdgeInsets(top: 2, left: 18, bottom: 2, right: 8)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    
    
}
