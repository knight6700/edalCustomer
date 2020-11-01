//
//  TextField+Images.swift
//  EdalCustomer
//
//  Created by Mahmoud Fares on 10/21/20.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit

class TextFieldImage: UITextField {

    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    @IBInspectable var topPadding: CGFloat = 0
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }

    @IBInspectable var CornerRadius: CGFloat = 12 {
        didSet {
            updateView()
        }

    }

    @IBInspectable var borderWidthh: CGFloat = 1.0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var borderColorr: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }

    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }

    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }

    @IBInspectable var PlaceholderColor: UIColor = UIColor.lightGray {
        didSet {
            updateView()

        }
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRec = super.leftViewRect(forBounds: bounds)
        textRec.origin.x += leftPadding
        return textRec
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRec = super.rightViewRect(forBounds: bounds)
        textRec.origin.x -= rightPadding
        return textRec
    }

    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftView = nil
            leftViewMode = UITextField.ViewMode.never
        }

        if let rightImage = rightImage {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = rightImage
            imageView.tintColor = color
            rightView = imageView
        } else {
            rightView = nil
            rightViewMode = UITextField.ViewMode.never
        }

        layer.borderWidth = borderWidthh
        layer.borderColor = borderColorr.cgColor
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2
        layer.masksToBounds = false
        layer.shadowOpacity = 1.0
        // set backgroundColor in order to cover the shadow inside the bounds
        layer.backgroundColor = UIColor.white.cgColor

        self.layer.cornerRadius  = CornerRadius
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0
       layer.backgroundColor = UIColor.clear.cgColor
    }

}
