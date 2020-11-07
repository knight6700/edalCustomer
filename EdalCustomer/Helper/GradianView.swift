//
//  GradianView.swift
//  EdalCustomer
//
//  Created by Mahmoud Fares on 10/7/20.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit
@IBDesignable
class GradientView: UIView {
    let gradientLayer = CAGradientLayer()

    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    override func layoutSubviews() {
        super .layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    @IBInspectable
    var gradianConrner: CGFloat = 0 {
        didSet {
            gradientLayer.cornerRadius = gradianConrner
            gradientLayer.masksToBounds = true
        }
    }

    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }

}
