//
//  ForgetPasswordVC.swift
//  edalCustomerTest
//
//  Created by Mohamed Kelany on 7/31/18.
//  Copyright © 2018 Mohamed Kelany. All rights reserved.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!

    @IBOutlet weak var forgetPasswordLabel: UILabel!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var forgetPasswordDescriptionLabel: UILabel!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var mobileErrorLabel: UILabel!
    // MARK: Properties
    private let redColor = UIColor(red: 207/255, green: 16/255, blue: 41/255, alpha: 1)
    private let lightColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    private var fieldIsRequiredMessage = "fieldIsRequired".localize()
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileField.delegate = self
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
        let grayColor = UIColor(rgb: 0xF3F3F3).withAlphaComponent(0.5)
        mobileView.roundView(withCorner: mobileField.frame.height/2, borderColor: grayColor, borderWidth: 1)
        sendButton.roundView(withCorner: sendButton.frame.height/2)
    }
    
//    // handleLocalization: to handle ar & en for the design
//    func handleLocalization(){
//        forgetPasswordLabel.text = "For_ForgetPasswordLabel".localiz()
//        forgetPasswordDescriptionLabel.text = "For_ForgetPasswordDescription".localiz()
//        sendButton.setTitle("For_SendButton".localiz(), for: .normal)
//        let grayColor = UIColor(rgb: 0xF3F3F3).withAlphaComponent(0.5)
//        phoneNumberField.attributedPlaceholder = NSAttributedString(string: "For_PhoneNumberPlaceHolder".localiz(),
//                                                               attributes: [NSAttributedStringKey.foregroundColor: grayColor])
//    }
    
    func handleNavigationBar(){
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    // MARK: Actions
    @IBAction func onTapSend(_ sender: UIButton) {
       // navigateToVerification()
        let isMobileValidate = mobileValidation()
        guard isMobileValidate else {return}
        sendVerificationCode()
    }
    
    func sendVerificationCode(){
        // customer/reset/send -> "send verificatione code" for forgot password
        let services = AuthenticationServices()
        let mobile = mobileField.text!
        showLoading()
        services.sendVerificationCode(withMobile: mobile) { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            
            guard let data = data else { return }
            Defaults.code = data.code ?? 0
            Defaults.Mobile = self.mobileField.text ?? ""
            let navigator = AuthNavigator(nav: self.navigationController)
            navigator.navigate(to: .verification(cameFrom: .forgetPassword))
        }
    }
    
    func navigateToVerification(){
        let navigator = AuthNavigator(nav: self.navigationController)
        navigator.navigate(to: .verification(cameFrom: .forgetPassword))
    }

    @IBAction func onTapClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ForgetPasswordVC: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == mobileField{
            let _ = mobileValidation()
        }
    }
}
extension ForgetPasswordVC {
    private func mobileValidation() -> Bool{
        guard let text = mobileField.text, mobileField.hasText else {
            mobileErrorLabel.text = fieldIsRequiredMessage
            handleColor(of: mobileField, hasError: true)
            return false
        }
        
        guard checkIfFieldHasNumber(text) else{
            mobileErrorLabel.text = "numbersOnly".localize()
            handleColor(of: mobileField, hasError: true)
            return false
        }
        
        if text.count == 11 {
            if (text.prefix(2)=="01"){
                print(text)
            } else {
                mobileErrorLabel.text = "Please enter a valid mobile number"
                handleColor(of: mobileField, hasError: true)
                return false
            }
        }
        
        if text.count == 10 {
            if (text.prefix(1)=="1"){
                print(text)
            } else {
                mobileErrorLabel.text = "Please enter a valid mobile number"
                handleColor(of: mobileField, hasError: true)
                return false
            }
        }
        
        guard text.count == 11 || text.count == 10 else {
            mobileErrorLabel.text = "Please enter a valid mobile number"
            handleColor(of: mobileField, hasError: true)
            return false
        }
        
        
        handleColor(of: mobileField, hasError: false)
        mobileErrorLabel.text = ""
        return true
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
    
    private func handleColor(of textField: UITextField, hasError: Bool){
        if hasError{
            textField.layer.borderColor = redColor.cgColor
        }else{
            textField.layer.borderColor = lightColor.cgColor
        }
    }
    
}
