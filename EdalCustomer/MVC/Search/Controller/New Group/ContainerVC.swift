//
//  ContainerVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/17/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit


class ContainerVC: SlideMenuController {

    var servicesId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func awakeFromNib() {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProviderServicesVC") {
            self.mainViewController = controller
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "FilterSideMenuVC") {
            self.leftViewController = controller
        }
        super.awakeFromNib()
    }


}
