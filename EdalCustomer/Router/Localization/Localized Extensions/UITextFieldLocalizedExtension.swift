//
//  TextFieldLocalizedExtension.swift
//  TestLocalization
//
//  Created by hesham ghalaab on 8/4/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    @IBInspectable var localizedKeyPlaceHolder: String {
        set {
            self.placeholder = "\(newValue).placeholder".localize()
        }
        get {
            return self.localizedKeyPlaceHolder
        }
    }
    
    @IBInspectable var autoTextAlignment: Bool{
        set(newValue){
            // if autoTextAlignment == true we will handle the alignment
            guard newValue else { return }
            guard LanguageManger.shared.isRightToLeft else{
                self.textAlignment = .left
                return
            }
            // if LanguageManger isRightToLeft
            self.textAlignment = .right
        }
        get{
            return self.autoTextAlignment
        }
    }
}

