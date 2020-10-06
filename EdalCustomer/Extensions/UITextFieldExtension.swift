//
//  UITextFieldExtension.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/5/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit


extension UITextField{
    func addLeftView(withWidth width: CGFloat = 8){
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 2.0))
        leftView.backgroundColor = UIColor.clear
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    
    


}
