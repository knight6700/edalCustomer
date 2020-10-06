//
//  VerificationVC.swift
//  edal-IosApp
//
//  Created by Mohamed Kelany on 7/31/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit



enum CameToVerificationFrom {
    case normalRegisteration
    case forgetPassword
}

enum SendCode {
    case registerMood
    case forgetPasswordMood
    case changeMobileInVerificationMood
}

class VerificationVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var thirdField: UITextField!
    @IBOutlet weak var fourthField: UITextField!
    @IBOutlet weak var fifthField: UITextField!
    
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var editPasswordView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var sendEditedPasswordButton: UIButton!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var mobileField: UITextField!
    
    @IBOutlet weak var mobileErrorLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var digitsStackView: UIStackView!
    // MARK: Properties
    var cameFrom = CameToVerificationFrom.normalRegisteration
    
    private let redColor = UIColor(red: 207/255, green: 16/255, blue: 41/255, alpha: 1)
    private let lightColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    private var fieldIsRequiredMessage = "fieldIsRequired".localize()
    
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
//        codeLabel.semanticContentAttribute = .forceLeftToRight
//        digitsStackView.semanticContentAttribute = .forceLeftToRight
//        firstField.semanticContentAttribute = .forceLeftToRight
//        secondField.semanticContentAttribute = .forceLeftToRight
//        thirdField.semanticContentAttribute = .forceLeftToRight
//        fourthField.semanticContentAttribute = .forceLeftToRight
//        fifthField.semanticContentAttribute = .forceLeftToRight
        configuration()
        setupUI()
      // checkTheCameFromToSendCode()
        switch cameFrom {

        case .normalRegisteration:
            // in case of normal registeration we will send the verifcation code ,
            // else will be handled on their screens like forget password.
           // self.codeLabel.text = "\(Defaults.code)"
            resendVerificationCode()
        case .forgetPassword:
            // in case forgetPassword we get send the verification code in its screen
            // and save it in defaults
            //self.codeLabel.text = Defaults.code.description
            self.codeLabel.text =  "\(Defaults.code)"
        }
    }
    
    override func didReceiveMemoryWarning() {
        print("error didReceiveMemoryWarning")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationBar()
        firstField.becomeFirstResponder()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//    }
//
    func handleNavigationBar(){
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.title = " "
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    func configuration(){
        mobileField.delegate = self
        firstField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        secondField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        thirdField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        fourthField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        fifthField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
    }
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
        submitButton.roundView(withCorner: submitButton.frame.height/2)
        sendEditedPasswordButton.roundView(withCorner: sendEditedPasswordButton.frame.height/2)
        passwordView.roundView(withCorner: passwordView.frame.height/2, borderColor: .lightGray, borderWidth: 1)
        mobileLabel.text = Defaults.Mobile
    }

    func checkTheCameFromToSendCode(){
        switch cameFrom {
        case .forgetPassword:
            sendVerificationCode()
        case .normalRegisteration:
            resendVerificationCode()
        }
    }
    
    @IBAction func textFieldDidChanged(_ textField: UITextField){
        let text = textField.text ?? ""
        print("textFieldDidChanged with text: \(text)")
        if text.count == 1 {
            // when writes one digit
            switch textField{
            case firstField:
                secondField.becomeFirstResponder()
            case secondField:
                thirdField.becomeFirstResponder()
            case thirdField:
                fourthField.becomeFirstResponder()
            case fourthField:
                fifthField.becomeFirstResponder()
            case fifthField:
                fifthField.resignFirstResponder()
                
                checkVerificationCode()
            default:
                break
            }
        }
    }
    
    
    
    @IBAction func submit(_ sender: UIButton) {
        checkVerificationCode()
    }
    
    func navigateToNextScreen(){
        switch cameFrom {
        case .normalRegisteration:
            let navigator = AuthNavigator(nav: self.navigationController)
            navigator.navigate(to: .termsAndConditions(cameFrom: .normalRegisteration))
            
        case .forgetPassword:
            let navigator = AuthNavigator(nav: self.navigationController)
            navigator.navigate(to: .newPassword)
            print("forgetPassword")
        }
    }
    
    
    var mobile: String?
    func resendVerificationCode(){
        // customer/register/userdata/resend "Change Mobile Number" in case that user register
        let services = AuthenticationServices()
        if mobileField.text == "" {
            mobile = Defaults.Mobile
        } else {
            mobile = mobileField.text!
        }
        showLoading()
        services.reSendVerificationCode(withMobile: mobile!) { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            
            guard let data = data else { return}
            self.codeLabel.text = (data.code ?? 0).description
            Defaults.code = data.code!
            
        }
    }

    func sendVerificationCode(){
        let services = AuthenticationServices()
        if mobileField.text == "" {
            mobile = Defaults.Mobile
        } else {
            mobile = mobileField.text!
        }
        showLoading()
        services.sendVerificationCode(withMobile: mobile!) { (error, data) in
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
    
    func checkVerificationCode(){
        
        guard firstField.hasText, secondField.hasText, thirdField.hasText, fourthField.hasText, fifthField.hasText else{
            alertUser(title: "", message: "please make sure to write the verification code")
            return
        }
        
        guard firstField.text?.utf16.count == 1 , secondField.text?.utf16.count == 1 , thirdField.text?.utf16.count == 1 , fourthField.text?.utf16.count == 1 , fifthField.text?.utf16.count == 1 else{
            alertUser(title: "", message: "make sure that each field have a minimum of 1 character")
            return
        }
        
        let code = firstField.text! + secondField.text! + thirdField.text! + fourthField.text! + fifthField.text!
        if mobileField.text == "" {
            mobile = Defaults.Mobile
        } else {
            mobile = mobileField.text!
        }
        showLoading()
        let services = AuthenticationServices()
        services.verifyCode(withCode: code, mobile: Defaults.Mobile) { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            
            guard let _ = data else { return }
            if let codeInInt = Int(code){
                Defaults.code = codeInInt
            }else{
                fatalError("code is here but it is changed to strig so please try to handle it")
            }
            
            self.navigateToNextScreen()
        }
    }
    
   
    
    @IBAction func resend(_ sender: UIButton) {
        checkTheCameFromToSendCode()
    }
    
    @IBAction func onTapsendEditedMobile(_ sender: UIButton) {
        
        
        let isMobileValidate = mobileValidation()
        if isMobileValidate {
            editPasswordView.isHidden = true
            mobileView.isHidden = false
            Defaults.Mobile = mobileField.text ?? ""
            mobileLabel.text = Defaults.Mobile
            checkTheCameFromToSendCode()
        }
        
    }
    
    
    @IBAction func onTapchangeNumber(_ sender: UIButton) {
        editPasswordView.isHidden = false
        mobileView.isHidden = true
    }
    
    
}
extension VerificationVC: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == mobileField{
            let _ = mobileValidation()
        }
    }
    
}

extension VerificationVC {
    
    
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
