//
//  UIButtonExtension.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/26/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

extension UIButton
{
    func addBlurEffect()
    {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blur.alpha = 0.8
        blur.frame = self.bounds
        blur.isUserInteractionEnabled = false
        self.insertSubview(blur, at: 0)
        if let imageView = self.imageView{
            self.bringSubviewToFront(imageView)
        }
    }
}
