//
//  NewPasswordVC.swift
//  edalCustomerTest
//
//  Created by Mohamed Kelany on 7/31/18.
//  Copyright © 2018 Mohamed Kelany. All rights reserved.
//

import UIKit

class NewPasswordVC: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var submitButton: UIButton!
    // MARK: Outlets
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    //@IBOutlet weak var submitButton: UIButton!
  //  @IBOutlet weak var termsAndConditionsButton: UILabel!
    @IBOutlet weak var newPasswordErrorLabel: UILabel!
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!
    // MARK: Properties
    private let redColor = UIColor(red: 207/255, green: 16/255, blue: 41/255, alpha: 1)
    private let lightColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    private var fieldIsRequiredMessage = "fieldIsRequired".localize()
    
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // handleLocalization()
        configuration()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    func configuration(){
        
    }
    
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
        submitButton.roundView(withCorner: submitButton.frame.height/2)
    }
    
    // handleLocalization: to handle ar & en for the design
    func handleLocalization(){
        self.title = "New_Title".localize()
        newPasswordField.placeholder = "New_NewPasswordPlaceHolder".localize()
        confirmPasswordField.placeholder = "New_ConfirmPassword".localize()
        submitButton.setTitle("New_SubmitButton".localize(), for: .normal)
        
        let isRight = LanguageManger.shared.isRightToLeft
        newPasswordField.textAlignment = isRight ? .right: .left
        confirmPasswordField.textAlignment = isRight ? .right: .left
        
        let firstText = "New_firstTextTermsAndConditions".localize()
        let secondText = "New_secondTextTermsAndConditions".localize()
        let firstAttribute = NSAttributedString(string: firstText,
                                                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                                                             NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        let secondAttribute = NSAttributedString(string: secondText,
                                                 attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                                                              NSAttributedString.Key.foregroundColor: UIColor.blueColor()])
        let text = NSMutableAttributedString(attributedString: firstAttribute)
        text.append(secondAttribute)
       // termsLabel.attributedText = text
    }
    
    func handleNavigationBar(){
        
    }
    
    // MARK: Actions
    @IBAction func onTapSubmit(_ sender: UIButton) {
        let isNewPasswordValidate = newPasswordValidation()
        let isConfirmPasswordValidate = confirmPasswordValidation()
        
        guard isNewPasswordValidate , isConfirmPasswordValidate else { return }
        resetPassword()
    }
    
    func resetPassword(){
        let services = AuthenticationServices()
        let mobile = Defaults.Mobile
        let code = Defaults.code.description
        let password = newPasswordField.text!
        showLoading()
        
        services.resetPassword(withMobile: mobile, code: code, password: password) { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            
            guard let _ = data else { return }
            self.navigateToPasswordResetSucceeded()
        }
    }
    
    private func navigateToPasswordResetSucceeded(){
        let navigator = AuthNavigator(nav: self.navigationController)
        navigator.navigate(to: .passwordResetSuccessed)
    }
    

    @IBAction func onTapTermsAndConditions(_ sender: UIButton) {
    }
    
}

extension NewPasswordVC{
    
    private func newPasswordValidation() -> Bool{
        guard let text = newPasswordField.text, newPasswordField.hasText else {
            newPasswordErrorLabel.text = fieldIsRequiredMessage
            handleColor(of: newPasswordField, hasError: true)
            return false
        }
        
        guard text.count >= 8 else {
            newPasswordErrorLabel.text = "8CharactersatLeast".localize()
            handleColor(of: newPasswordField, hasError: true)
            return false
        }
        
        guard checkPasswordConfirmation(password: text) else{
            newPasswordErrorLabel.text = "oneNumOneChar".localize()
            handleColor(of: newPasswordField, hasError: true)
            return false
        }
        
        handleColor(of: newPasswordField, hasError: false)
        newPasswordErrorLabel.text = ""
        return true
    }
    
    private func confirmPasswordValidation() -> Bool{
        guard let text = confirmPasswordField.text, confirmPasswordField.hasText else {
            confirmPasswordErrorLabel.text = fieldIsRequiredMessage
            handleColor(of: confirmPasswordField, hasError: true)
            return false
        }
        
        guard let passwordText = newPasswordField.text else {
            // check if password field has text
            return false
        }
        
        guard text == passwordText else {
            confirmPasswordErrorLabel.text = "passwordNotMatched".localize()
            handleColor(of: confirmPasswordField, hasError: true)
            return false
        }
        
        handleColor(of: confirmPasswordField, hasError: false)
        confirmPasswordErrorLabel.text = ""
        return true
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

