//
//  UpdatedPasswordVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/16/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class UpdatedPasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.handleNavigationBars()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ontappedLoginNowButton(_ sender: UIButton) {
        let navigator = AuthNavigator(nav: self.navigationController)
        navigator.navigate(to: .login)
    }
}
