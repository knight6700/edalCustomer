//
//  ReopenComplaintVC.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 9/11/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class ReopenComplaintVC: UIViewController {

    // MARK: Outlets
    
    // MARK: Properties
    
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
        setupUI()
    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    func configuration(){
        
    }
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
        
    }
    
    // MARK: Actions
    @IBAction func onTapReopen(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
