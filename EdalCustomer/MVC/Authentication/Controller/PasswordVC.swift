//
//  PasswordVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/2/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class PasswordVC: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var passwordErrorInlineLabel: UILabel!
    @IBOutlet weak var confirmPasswordErrorInlineLabel: UILabel!
    
    private let redColor = UIColor(red: 207/255, green: 16/255, blue: 41/255, alpha: 1)
    private let lightColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    private var fieldIsRequiredMessage = "This field is required".localize()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // handleNavigationBar()
       // hideErrorInlineLabels()
        setUpUI()

        // Do any additional setup after loading the view.
    }
    
    func handleNavigationBar(){
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.title = " "
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setUpUI() {
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        passwordField.roundView(withCorner: 4, borderColor: lightColor, borderWidth: 0.5)
        confirmPasswordField.roundView(withCorner: 4, borderColor: lightColor, borderWidth: 0.5)
        nextButton.roundView(withCorner: nextButton.frame.height/2, borderColor: .gray, borderWidth: 0.5)
    }


    func validateUserLocally() {

       
    }
    
    private func saveUserDataInDefaults(){
        Defaults.Password = passwordField.text ?? ""
        navigateToVerification()
    }
    func navigateToVerification() {
        let navigator = AuthNavigator(nav: self.navigationController)
        navigator.navigate(to: .verification(cameFrom: .normalRegisteration))
    }

    @IBAction func onTapNext(_ sender: UIButton) {
        let isPasswordValidate = passwordValidation()
        let isConfirmPasswordValidate = confirmPasswordValidation()
        
        guard isPasswordValidate, isConfirmPasswordValidate else{
                return
        }
        
        let email = Defaults.Email
        let mobile = Defaults.Mobile
        guard let password = passwordField.text else {return}
       // Defaults.Password = password
        saveUserDataInDefaults()
        print(email)
        print(mobile)
        print(password)
      //  validateUserData(withEmail: email, mobile: mobile, password: password)
       
    }
    

    
}

extension PasswordVC: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == passwordField{
            let _ = passwordValidation()
        }else if textField == confirmPasswordField{
            let _ = confirmPasswordValidation()
        }
    }
}


extension PasswordVC {
    
    private func passwordValidation() -> Bool{
        guard let text = passwordField.text, passwordField.hasText else {
            passwordErrorInlineLabel.text = fieldIsRequiredMessage
            handleColor(of: passwordField, hasError: true)
            return false
        }
        
        guard text.count >= 8 else {
            passwordErrorInlineLabel.text = "Enter at least 8 characters"
            handleColor(of: passwordField, hasError: true)
            return false
        }
        
        guard checkPasswordConfirmation(password: text) else{
            passwordErrorInlineLabel.text = "Enter at least 1 Alphabet and 1 Number"
            handleColor(of: passwordField, hasError: true)
            return false
        }
        
        handleColor(of: passwordField, hasError: false)
        passwordErrorInlineLabel.text = ""
        return true
    }
    
    private func confirmPasswordValidation() -> Bool{
        guard let text = confirmPasswordField.text, confirmPasswordField.hasText else {
            confirmPasswordErrorInlineLabel.text = fieldIsRequiredMessage
            handleColor(of: confirmPasswordField, hasError: true)
            return false
        }
        
        guard let passwordText = passwordField.text else {
            // check if password field has text
            return false
        }
        
        guard text == passwordText else {
            confirmPasswordErrorInlineLabel.text = "password is not matched"
            handleColor(of: confirmPasswordField, hasError: true)
            return false
        }
        
        handleColor(of: confirmPasswordField, hasError: false)
        confirmPasswordErrorInlineLabel.text = ""
        return true
    }
    
    private func checkPasswordConfirmation(password: String) -> Bool{
        let REGEX: String
        REGEX = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordIsGood = NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: password)
        return passwordIsGood
    }
    
    private func checkIfFieldHasNumber(_ text: String) -> Bool{
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = text.rangeOfCharacter(from: decimalCharacters)
        
        if decimalRange == nil {
            // numbers not found
            return false
        }else{
            // numbers found
            return true
        }
    }
    
    
    private func handleColor(of view: UIView, hasError: Bool){
        if hasError{
            view.layer.borderColor = redColor.cgColor
        }else{
            view.layer.borderColor = lightColor.cgColor
        }
    }

}
