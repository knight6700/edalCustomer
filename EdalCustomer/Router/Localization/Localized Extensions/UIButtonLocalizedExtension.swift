//
//  ButtonLocalizedExtension.swift
//  TestLocalization
//
//  Created by hesham ghalaab on 8/4/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    @IBInspectable var localizedKey: String {
        set {
            setTitle("\(newValue).normalTitle".localize(), for: .normal)
        }
        
        get {
            return titleLabel?.text ?? ""
        }
    }
}
