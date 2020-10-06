//
//  PasswordResetSuccessedVC.swift
//  edalCustomerTest
//
//  Created by Mohamed Kelany on 7/31/18.
//  Copyright © 2018 Mohamed Kelany. All rights reserved.
//

import UIKit

class PasswordResetSuccessedVC: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var passwordResetLabel: UILabel!
    
    // MARK: Properties
    
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  handleLocalization()
        configuration()
        setupUI()
    }

    // MARK: Methods
    // configuration: to configure any protocols
    func configuration(){
        
    }
    
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
        loginButton.roundView(withCorner: loginButton.frame.height/2)
    }
    
    // handleLocalization: to handle ar & en for the design
    func handleLocalization(){
        self.title = "Pas_Title".localize()
        passwordResetLabel.text = "Pas_PasswordResetLabel".localize()
        loginButton.setTitle("pas_LoginNowButton".localize(), for: .normal)
    }

    
    // MARK: Actions
    @IBAction func onTapLogin(_ sender: UIButton) {
        UIApplication.topViewController?.dismiss(animated: true, completion: nil)
    }
    

}
