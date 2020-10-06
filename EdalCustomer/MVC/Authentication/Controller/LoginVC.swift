//
//  LoginVC.swift
//  edalCustomerTest
//
//  Created by Mohamed Kelany on 7/31/18.
//  Copyright © 2018 Mohamed Kelany. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
  
    @IBOutlet weak var passwordErrorLabel: UILabel!

    //MARK:- Properties
    private let redColor = UIColor(red: 207/255, green: 16/255, blue: 41/255, alpha: 1)
    private let lightColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    private var fieldIsRequiredMessage = "fieldIsRequired".localize()
    
  
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // handleLocalization()
        
       // self.navigationController?.view.backgroundColor = .clear
        //self.navigationController?.navigationBar
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        configuration()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    func configuration(){
//        let bar:UINavigationBar! =  self.navigationController?.navigationBar
//        //self.title = "Whatever..."
//        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        bar.shadowImage = UIImage()
//        bar.alpha = 0.0
    }
    
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
        emailField.delegate = self
        passwordField.delegate = self
        loginButton.roundView(withCorner: loginButton.frame.height/2)
        emailField.roundView(withCorner: emailField.frame.height/2)
        passwordField.roundView(withCorner: passwordField.frame.height/2)
        
        // add left view ass apadding
        emailField.addLeftView()
        passwordField.addLeftView()
        
    }
    
    // handleLocalization: to handle ar & en for the design
    func handleLocalization(){
       // self.title = "New_Title".localiz()
        emailField.placeholder = "Log_EmailPlaceHolder".localize()
        passwordField.placeholder = "Log_PasswordPlaceHolder".localize()
        forgetPasswordButton.setTitle("Log_ForgetButton".localize(), for: .normal)
        loginButton.setTitle("Log_LoginButton".localize(), for: .normal)
        
        let isRight = LanguageManger.shared.isRightToLeft
        emailField.textAlignment = isRight ? .right: .left
        passwordField.textAlignment = isRight ? .right: .left
        
       
    }
    

    @IBAction func onTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Actions
    @IBAction func onTapLogin(_ sender: UIButton) {


        
        let isEmailValidate = emailValidation()
        let isPasswordValidate = passwordValidation()
        
        guard isEmailValidate, isPasswordValidate else {return}
        
        let email = emailField.text!
        let password = passwordField.text!
        let services = AuthenticationServices()
        showLoading()
        services.loginUser(withEmail: email, password: password) { (error, data) in
             self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            
            guard let data = data else {return}
            Defaults.token = (data.customer?.api_token)!
            print("token:\(Defaults.token)")
            Defaults.FirstName = (data.customer?.first_name)!
            Defaults.LastName = (data.customer?.last_name)!
            Defaults.Email = (data.customer?.email)!

            if Defaults.isNotFirstTimeUsingApp {
                let navigator = ProfileNavigator(nav: self.navigationController)
                navigator.navigate(to: .home)
            } else {
                let navigator = ProfileNavigator(nav: self.navigationController)
                navigator.navigate(to: .categories)
            }
        }
        

    }
    
    
    @IBAction func onTapForgetPassword(_ sender: UIButton) {
        let presenter = AuthPresenter(vc: self)
        presenter.present(.forgotPassword)
    }
    
   
}

extension LoginVC: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailField{
            let _ = emailValidation()
        }else if textField == passwordField{
            let _ = passwordValidation()
        }
    }
}

extension LoginVC{
    private func emailValidation() -> Bool{
        guard let text = emailField.text, emailField.hasText else {
            emailErrorLabel.text = fieldIsRequiredMessage
            handleColor(of: emailField, hasError: true)
            return false
        }
        
        guard checkEmailConfirmation(emailAddress: text) else{
            emailErrorLabel.text = "emailNotValid".localize()
            handleColor(of: emailField, hasError: true)
            return false
        }
        
        handleColor(of: emailField, hasError: false)
        emailErrorLabel.text = ""
        return true
    }
    
    private func passwordValidation() -> Bool{
        guard let text = passwordField.text, passwordField.hasText else {
            passwordErrorLabel.text = fieldIsRequiredMessage
            handleColor(of: passwordField, hasError: true)
            return false
        }
        
        guard checkPasswordConfirmation(password: text) else{
            passwordErrorLabel.text = "passwordNotValid".localize()
            handleColor(of: passwordField, hasError: true)
            return false
        }
        
        handleColor(of: passwordField, hasError: false)
        passwordErrorLabel.text = ""
        return true
    }
    
    private func checkEmailConfirmation(emailAddress: String) -> Bool{
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailIsGood = NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: emailAddress)
        return emailIsGood
    }
    
    private func checkPasswordConfirmation(password: String) -> Bool{
        let REGEX: String
        REGEX = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordIsGood = NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: password)
        return passwordIsGood
    }
    
    private func handleColor(of textField: UITextField, hasError: Bool){
        if hasError{
            textField.layer.borderColor = redColor.cgColor
        }else{
            textField.layer.borderColor = lightColor.cgColor
        }
    }
}
