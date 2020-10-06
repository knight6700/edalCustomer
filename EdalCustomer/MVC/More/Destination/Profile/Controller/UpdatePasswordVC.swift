//
//  UpdatePasswordVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/12/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class UpdatePasswordVC: UIViewController {
    
    @IBOutlet weak var currentPasswordTextField: UITextField!
    
    @IBOutlet weak var currentPasswordErrorLabel: UILabel!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var newPasswordErrorLabel: UILabel!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    
    @IBOutlet weak var changePasswordButton: UIButton!
    
    
    // MARK: Properties
    private let redColor = UIColor(red: 207/255, green: 16/255, blue: 41/255, alpha: 1)
    private let lightColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    private var fieldIsRequiredMessage = "fieldIsRequired".localize()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onTappedChangePassword(_ sender: UIButton) {
        
        // let isMobileValidate = mobileValidation()
       // guard isMobileValidate else {return}
        sendVerificationCode()
        
        let navigator = ProfileNavigator(nav: self.navigationController)
        navigator.navigate(to: .updatedPassword)
        // self.navigationController?.popViewController(animated: true)
    }
    
    func updatePassword(){
        guard let currentPassword = currentPasswordTextField.text else {return}
        guard let newPassword = newPasswordTextField.text else {return}
        guard let confirmPassword = confirmPasswordTextField.text else {return}
        let services = ProfileServices()
        services.updatePassword(passowrd: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword) { (error, data) in
            if let error = error {
                self.alertUser(title: "", message: error)
                return
            }
            
            guard let data = data else {return}
            //Defaults.Password = data.
        }
        let navigator = ProfileNavigator(nav: self.navigationController)
        navigator.navigate(to: .updatedPassword)
    }
    
    func sendVerificationCode(){
        // customer/reset/send -> "send verificatione code" for forgot password
        let services = AuthenticationServices()
        //  let mobile = mobileField.text!
        showLoading()
        services.sendVerificationCode(withMobile: Defaults.Mobile) { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            
            guard let data = data else { return }
            Defaults.code = data.code ?? 0
          //  Defaults.Mobile = self.mobileField.text ?? ""
            let navigator = AuthNavigator(nav: self.navigationController)
           // navigator.navigate(to: .verification(cameFrom: .forgetPassword))
        }
    }
    
    func navigateToVerification(){
        let navigator = ProfileNavigator(nav: self.navigationController)
        navigator.navigate(to: .updatePassword)
    }
}


extension UpdatePasswordVC {

    private func handleColor(of textField: UITextField, hasError: Bool){
        if hasError{
            textField.layer.borderColor = redColor.cgColor
        }else{
            textField.layer.borderColor = lightColor.cgColor
        }
    }
    
}





