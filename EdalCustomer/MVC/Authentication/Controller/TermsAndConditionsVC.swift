//
//  TermsaAndConditionsVC.swift
//  edalCustomerTest
//
//  Created by Mohamed Kelany on 7/31/18.
//  Copyright © 2018 Mohamed Kelany. All rights reserved.
//

import UIKit

enum CameToTermsAndConditionsFrom {
    case normalRegisteration
    case newPassword
}

class TermsAndConditionsVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var agreeAndSubmitButton: UIButton!
    @IBOutlet weak var termsAndConditionsView: UITextView!
    @IBOutlet weak var progressStack: UIStackView!
    
    // MARK: Properties
    var cameFrom = CameToTermsAndConditionsFrom.normalRegisteration
    
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
        setupUI()
        printDefaults()
    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    func configuration(){
        agreeAndSubmitButton.roundView(withCorner: agreeAndSubmitButton.frame.height/2, borderColor: .gray, borderWidth: 0.5)
    }
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
       // termsAndConditionsView.text = Defaults.ter
        termsAndConditionsView.text = Defaults.termsAndConditions
        
        if cameFrom == .normalRegisteration{
            agreeAndSubmitButton.isHidden = false
            progressStack.isHidden = false
        }else if cameFrom == .newPassword{
            agreeAndSubmitButton.isHidden = true
            progressStack.isHidden = true
        }
    }
    
    func printDefaults() {
        print(Defaults.FirstName)
        print(Defaults.LastName)
        print(Defaults.Mobile)
        print(Defaults.Email)
        print(Defaults.Gender)
        print(Defaults.AgeId)
        //print(Defaults.FirstName)
        print(Defaults.DistrictId)
        print(Defaults.Location.address)
        print(Defaults.Latitude)
        print(Defaults.Longitude)
//        print(Defaults.Password)
        print(Defaults.code)
        print(Defaults.DeviceId)
        print(Defaults.FirebaseToken)
        
    }
    
    // MARK: Actions
    @IBAction func onTapSubmit(_ sender: UIButton) {
        registerUser()
    }
    
    func registerUser(){
        let services = AuthenticationServices()
        showLoading()
        services.registerUser { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            
            guard let data = data else {return}
            if Defaults.SocialId != "" && Defaults.SocialProvider != "" && Defaults.SocialToken != "" {
                Defaults.token = (data.customer?.api_token)!
                print("token:\(Defaults.token)")
                Defaults.FirstName = (data.customer?.first_name)!
                Defaults.LastName = (data.customer?.last_name)!
                Defaults.Email = (data.customer?.email)!
                let navigator = ProfileNavigator(nav: self.navigationController)
                navigator.navigate(to: .home)
            } else {
            // do login after registeration to retrieve token
            let email = (data.customer?.email)!
            let password = Defaults.Password
            
            services.loginUser(withEmail: email, password: password) { (error, dataL) in
                self.hideLoading()
                if let error = error{
                    self.alertUser(title: "", message: error)
                    return
                }
                
                guard let data = dataL else {return}
                Defaults.token = (dataL!.customer?.api_token)!
                print("token:\(Defaults.token)")
                Defaults.FirstName = (dataL!.customer?.first_name)!
                Defaults.LastName = (dataL!.customer?.last_name)!
                Defaults.Email = (dataL!.customer?.email)!
                
                self.navigateToThankYou()
            }
            
        }
        }
    }
    
    func navigateToThankYou(){
        let navigator = AuthNavigator(nav: self.navigationController)
        navigator.navigate(to: .thankYou)
    }
    
}
