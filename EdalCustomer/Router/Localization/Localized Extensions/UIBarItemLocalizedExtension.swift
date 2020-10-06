//
//  BarItemLocalizedExtension.swift
//  TestLocalization
//
//  Created by hesham ghalaab on 8/4/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

extension UIBarItem{
    @IBInspectable var localizedKey: String {
        set {
            self.title = "\(newValue).title".localize()
        }
        get {
            return self.localizedKey
        }
    }
}
