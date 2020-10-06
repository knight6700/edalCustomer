//
//  ComplaintsInfoVC.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 9/11/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class ComplaintsInfoVC: UIViewController {

    // MARK: Outlets
    
    // MARK: Properties
    
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // there are two case here if they are not changed later , the first is pending and it will not have a reaopen button , the second is closed and it will have the reopen button , and there is a change in the colors , please look at zeplin.
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
        let presenter = ComplaintsPresenter(vc: self)
        presenter.present(.reopenComplaint)
    }
    

    

}
