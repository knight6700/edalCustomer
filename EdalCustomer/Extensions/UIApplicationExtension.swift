//
//  UIApplicationExtension.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 8/1/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

// MARK: UIApplication extension
extension UIApplication {
    // Get top view controller
    static var topViewController:UIViewController? {
        get{
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                return topController
            }else{
                return nil
            }
        }
    }
    
}
