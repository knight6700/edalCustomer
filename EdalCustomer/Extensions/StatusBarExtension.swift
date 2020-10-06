//
//  StatusBarExtension.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 11/5/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}
