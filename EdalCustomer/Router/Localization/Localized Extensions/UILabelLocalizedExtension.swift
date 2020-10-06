//
//  LabelLocalizedExtension.swift
//  TestLocalization
//
//  Created by hesham ghalaab on 8/4/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    @IBInspectable var localizedKey: String {
        set {
            text = "\(newValue).text".localize()
        }
        
        get {
            return self.localizedKey
        }
    }
}
