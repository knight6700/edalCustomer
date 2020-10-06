//
//  UIViewControllerExtension.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/26/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func alertUser(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: completion)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
extension UIViewController {
    
    func setNavigationBarItem() {
       // self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.addRightBarButtonWithImage(UIImage(named: "fillter")!)
       // self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        //elf.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        //self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        //self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
}

