//
//  DesignableView.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/31/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//


import UIKit
import Foundation




@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableTextField: UITextField {
    var bottomBorder = UIView()
    
    override open func awakeFromNib() {
        
        // Setup Bottom-Border
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor.init(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0) // Set Border-Color
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bottomBorder)
        
        if #available(iOS 9.0, *) {
            bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        } else {
            // Fallback on earlier versions
        } // Set Border-Strength
        
    }
    
    @IBInspectable var rightImage : UIImage? {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable var rightPadding : CGFloat = 0 {
        didSet {
            updateRightView()
        }
    }
    
    
    func updateRightView() {
        if let image = rightImage {
            rightViewMode = .always
            
            // assigning image
            let imageView = UIImageView(frame: CGRect(x: rightPadding, y: 0, width: 15, height: 15))
            imageView.image = image
            
            var width = rightPadding - 20
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width -= 5
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15)) // has 5 point higher in width in imageView
            view.addSubview(imageView)
            
            
            rightView = view
            
        } else {
            // image is nill
            rightViewMode = .never
        }
    }
}

@IBDesignable
class DesignableButton: UIButton {
    
    
    
    @IBInspectable var titleLeftPadding : CGFloat = 0.0  {
        
        didSet {
            
            titleEdgeInsets.left = titleLeftPadding
        }
    }
    @IBInspectable var titleRightPadding : CGFloat = 0.0  {
        
        didSet {
            
            titleEdgeInsets.right = titleRightPadding
        }
    }
    @IBInspectable var titleTopPadding : CGFloat = 0.0  {
        
        didSet {
            
            titleEdgeInsets.top = titleTopPadding
        }
    }
    @IBInspectable var titleBottomPadding : CGFloat = 0.0  {
        
        didSet {
            
            titleEdgeInsets.bottom = titleBottomPadding
        }
    }
    @IBInspectable var imageLeftpadding : CGFloat = 0.0 {
        
        didSet {
            
            imageEdgeInsets.left = imageLeftpadding
        }
    }
    @IBInspectable var imageRightpadding : CGFloat = 0.0 {
        
        didSet {
            
            imageEdgeInsets.right = imageRightpadding
        }
    }
    @IBInspectable var imageToppadding : CGFloat = 0.0 {
        
        didSet {
            
            imageEdgeInsets.top = imageToppadding
        }
    }
    @IBInspectable var imageBottompadding : CGFloat = 0.0 {
        
        didSet {
            
            imageEdgeInsets.bottom = imageBottompadding
        }
    }
    
    //Adjusting cornerRadius
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.size.height
        clipsToBounds = true
    }
}

@IBDesignable
class DesignableNavBar: UINavigationBar {
    
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable var shadowX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowY: CGFloat = -3 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowBlur: CGFloat = 3 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var startPointX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var startPointY: CGFloat = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var endPointX: CGFloat = 1 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var endPointY: CGFloat = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            self.gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
            self.gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
            self.layer.mask = gradientLayer
            //layer.addSublayer(gradientLayer) //insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    
    func animate(duration: TimeInterval, newTopColor: UIColor, newBottomColor: UIColor) {
        let fromColors = self.gradientLayer.colors
        let toColors: [AnyObject] = [ newTopColor.cgColor, newBottomColor.cgColor]
        self.gradientLayer.colors = toColors
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = duration
        animation.isRemovedOnCompletion = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        self.gradientLayer.add(animation, forKey:"animateGradient")
    }
    
    
}
@IBDesignable
class DesignableFullButton: UIButton {
    
    
    var gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable var shadowX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowY: CGFloat = -3 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowBlur: CGFloat = 3 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var startPointX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var startPointY: CGFloat = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var endPointX: CGFloat = 1 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var endPointY: CGFloat = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            self.gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
            self.gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.size.height
        clipsToBounds = true
        
    }
    
    func animate(duration: TimeInterval, newTopColor: UIColor, newBottomColor: UIColor) {
        let fromColors = self.gradientLayer.colors
        let toColors: [AnyObject] = [ newTopColor.cgColor, newBottomColor.cgColor]
        self.gradientLayer.colors = toColors
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = duration
        animation.isRemovedOnCompletion = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        self.gradientLayer.add(animation, forKey:"animateGradient")
    }
    
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
    
    
    
    
    
}
