//
//  UIViewExtension.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/28/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

extension UIView{
    
    func roundView(withCorner radius: CGFloat, borderColor: UIColor = .clear, borderWidth: CGFloat = 0){
        layer.cornerRadius = radius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }
    
    
    func addShadow(withCorner radius: CGFloat, borderColor: UIColor = .clear, borderWidth: CGFloat = 0, shadowColor: UIColor = .black, shadowOffset: CGSize = .zero, shadowRadius: CGFloat = 1, shadowOpacity: Float = 0.3){
        layer.cornerRadius = radius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    
    func makeShadow(withCorner radius: CGFloat, borderColor: UIColor = .clear, borderWidth: CGFloat = 0, shadowColor: UIColor = .black, shadowOffset: CGSize = .zero, shadowRadius: CGFloat = 2.5, shadowOpacity: Float = 0.3){
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        
        layer.cornerRadius = radius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
    
    func addShadow(withCorner radius: CGFloat, borderColor: UIColor = .clear, backgroundColor: UIColor ,borderWidth: CGFloat = 0, shadowColor: UIColor = .black, shadowOffset: CGSize = .zero, shadowRadius: CGFloat = 2.5, shadowOpacity: Float = 0.3){
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        shadowLayer.fillColor = backgroundColor.cgColor
        
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = shadowOffset
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowRadius
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func addCategoryShadow() {
        layer.cornerRadius = 13
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 1.75)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.shouldRasterize = true
    }
    
    
    
}

extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromRight(_ duration: TimeInterval = 0.4, completionDelegate: CAAnimationDelegate? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: CAAnimationDelegate = completionDelegate {
            slideInFromRightTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideInFromRightTransition.type = CATransitionType.push
        slideInFromRightTransition.subtype = CATransitionSubtype.fromRight
        slideInFromRightTransition.duration = duration
        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        slideInFromRightTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
    
    func slideInToRight(_ duration: TimeInterval = 0.4, completionDelegate: CAAnimationDelegate? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: CAAnimationDelegate = completionDelegate {
            slideInFromRightTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideInFromRightTransition.type = CATransitionType.push
        slideInFromRightTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromRightTransition.duration = duration
        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        slideInFromRightTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromUp(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromTop
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromUpTransition")
    }
    
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInToUp(duration: TimeInterval = 0.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromBottom
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideIntoUpTransition")
    }
}
