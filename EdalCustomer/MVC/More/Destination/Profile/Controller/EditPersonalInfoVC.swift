//
//  EditPersonalInfoVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/12/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
protocol EditPersonalInfoDelegate {
    func didEditPersonalInfo()
}
class EditPersonalInfoVC: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var firstNameErrorInlineLabel: UILabel!
    @IBOutlet weak var lastNameErrorInlineLabel: UILabel!
    @IBOutlet weak var mobileErrorInlineLabel: UILabel!
    @IBOutlet weak var emailErrorInlineLabel: UILabel!
    @IBOutlet weak var genderErrorInlineLabel: UILabel!
    @IBOutlet weak var ageErrorInlineLabel: UILabel!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var selectedAgeView: UIView!
    @IBOutlet weak var selectAgeButton: UIButton!
    @IBOutlet weak var mobileView: UIView!
    
    // MARK: Properties
    private let redColor = UIColor(red: 207/255, green: 16/255, blue: 41/255, alpha: 1)
    private let lightColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    private var fieldIsRequiredMessage = "This field is required".localize()
    var email: String!
    var firstName: String!
    var lastName: String!
    var SelectedAge: LookupAllData?{
        didSet{ selectAgeButton.setTitle(SelectedAge?.title, for: .normal) }
    }
    
    var picker_Image: UIImage?{
        didSet{
            guard let image = picker_Image else { return }
            uploadImage(with: image)
        }
    }
    
    var lookUpAll: LookupAllModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: Methods
    // configuration: to configure any protocols
    private func configuration(){
        
        lookupAll()
        
        
    }
    // setupUI: to setup data or make a custom design
    private func setupUI(){
        firstNameField.roundView(withCorner: 4, borderColor: lightColor, borderWidth: 0.5)
        lastNameField.roundView(withCorner: 4, borderColor: lightColor, borderWidth: 0.5)
        mobileView.roundView(withCorner: 4, borderColor: lightColor, borderWidth: 0.5)
        emailField.roundView(withCorner: 4, borderColor: lightColor, borderWidth: 0.5)
        profileImageView.roundView(withCorner: profileImageView.frame.width/2)
        
        let light = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        selectedAgeView.roundView(withCorner: 4, borderColor: light, borderWidth: 0.5)
        // add left view ass apadding
        firstNameField.addLeftView()
        lastNameField.addLeftView()
        mobileField.addLeftView()
        emailField.addLeftView()
        setupPersonalInfoData()
        //setting check box
        // maleButton.setImage(UIImage(named: "done"), for: .normal)
        //  Defaults.Gender = 1
        //  femaleButton.setImage(UIImage(named: "uncheck"), for: .normal)
        
    }
    
    private func setupPersonalInfoData(){
        profileImageView.addImage(withImage: Defaults.Image, andPlaceHolder: "BPLogo")
        firstNameField.text = Defaults.FirstName
        lastNameField.text = Defaults.LastName
        mobileField.text = Defaults.Mobile
        emailField.text = Defaults.Email
        SelectedAge = LookupAllData(id: Defaults.AgeId, title: Defaults.AgeTitle, name: nil, icon: nil)
        if Defaults.Gender == 1 {
            maleButton.setImage(UIImage(named: "done"), for: .normal)
            femaleButton.setImage(UIImage(named: "uncheck"), for: .normal)
        }else {
            maleButton.setImage(UIImage(named: "uncheck"), for: .normal)
            femaleButton.setImage(UIImage(named: "done"), for: .normal)
        }
        
        profileNameLabel.text = Defaults.FirstName + " " + Defaults.LastName
        profileEmailLabel.text = Defaults.Email
        
        
        
    }
    
    @IBAction func onTappedCamera(_ sender: UIButton) {
//        guard let picker = picker_Image else {
//            self.alertUser(title: "", message: "you should pick an image")
//            return
//        }
       addImage()
//       uploadImage(with: picker)
    }
    
    
   
    
    
    
    //MARK:- Methods
    //APIs Methods
    func uploadImage(with image: UIImage){
        showLoading()
        ProfileServices().updateImage(withImage: image) { (error, response) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                self.profileImageView.image =  #imageLiteral(resourceName: "avatar")
                // self.imagePath = nil
                return
            }
            
            guard let response = response else {
                self.profileImageView.image = #imageLiteral(resourceName: "avatar")
                return
            }
            
            self.profileImageView.image = self.picker_Image
            //Defaults.token = response.customer.api_token!
        }
    }
    
   
    func lookupAll(){
        let services = AuthenticationServices()
        showLoading()
        services.lookupAll { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            
            guard let _data = data else{ return }
//            self.lookUpAll = _data
        }
    }
        
    @IBAction func onTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    var checked = true
    @IBAction func onTappedMaleButton(_ sender: UIButton) {
        
        if checked == false {
            maleButton.setImage(UIImage(named: "uncheck"), for: .normal)
            femaleButton.setImage(UIImage(named: "done"), for: .normal)
            Defaults.Gender = 0
            
        }
        else {
            femaleButton.setImage(UIImage(named: "uncheck"), for: .normal)
            maleButton.setImage(UIImage(named: "done"), for: .normal)
            Defaults.Gender = 1
        }
        checked = true
        print(Defaults.Gender)
        
    }
    @IBAction func onTappedFemaleButton(_ sender: UIButton) {
        
        if checked == false {
            maleButton.setImage(UIImage(named: "done"), for: .normal)
            femaleButton.setImage(UIImage(named: "uncheck"), for: .normal)
            Defaults.Gender = 1
        }
        else {
            femaleButton.setImage(UIImage(named: "done"), for: .normal)
            maleButton.setImage(UIImage(named: "uncheck"), for: .normal)
            Defaults.Gender = 0
        }
        checked = true
        print(Defaults.Gender)
        
    }
    
    @IBAction func onTappedAgeButton(_ sender: UIButton) {
        let presnter = AuthPresenter(vc: self)
        presnter.present(.lookUpPopUp(type: .selectAge, lookUpAll: lookUpAll, lookUpDistricts: nil))
        
    }
    
    
    @IBAction func onTappedSaveButton(_ sender: UIButton) {
 
        let isFirstNameValidate = firstNameValidation()
        let isLastNameValidate = lastNameValidation()
        let isMobileValidate = mobileValidation()
        let isEmailValidate = emailValidation()
        
        if  isFirstNameValidate, isLastNameValidate, isMobileValidate,
            isEmailValidate {
            let services = ProfileServices()
            self.showLoading()
            services.updateCustomerPersonalInfo(firstName: firstNameField.text!, lastName: lastNameField.text!, email: emailField.text!, gender: Defaults.Gender, age: (SelectedAge?.id)!) { (error, errors, data)  in
                self.hideLoading()
                if let error = error {
                    self.alertUser(title: "", message: error)
                    return
                }
                
                if let error = errors{
                    if let error = error["email"]{
                        self.alertUser(title: "", message: error)
                        return
                    }
                    if let error = error["code"]{
                        self.alertUser(title: "", message: error)
                    }
                    return
                }
                guard let customer = data?.default_response.customer else {return}
                print("customer", customer)
                Defaults.saveUserData(with: customer)
            }
            
        }
        
        
    }
    
    
    

}

extension EditPersonalInfoVC: LookUpPopUpDataSource {
    func citySelectedWith(city: LookupAllDataModel) {
        return
    }
    
    func districtSelectedWith(district: LookupAllDataModel) {
        return
    }
    
    
    func ageSelectedwith(age: LookupAllDataModel) {
        print("Customer with selectedAge \(age)")
        self.SelectedAge = LookupAllData(id: age.id!, title: age.title!, name: age.name!, icon: age.icon!)
//        self.SelectedAge = age
    }
}

// MARK: Check for the fields
extension EditPersonalInfoVC {
    
    // first name validation
    private func firstNameValidation() -> Bool{
        guard let text = firstNameField.text, firstNameField.hasText else {
            firstNameErrorInlineLabel.text = fieldIsRequiredMessage
            handleColor(of: firstNameField, hasError: true)
            return false
        }
        
        guard !checkIfFieldHasNumber(text) else{
            firstNameErrorInlineLabel.text = "This field must have letters only"
            handleColor(of: firstNameField, hasError: true)
            return false
        }
        
        firstNameErrorInlineLabel.text = ""
        handleColor(of: firstNameField, hasError: false)
        return true
    }
    //last name validation
    private func lastNameValidation() -> Bool{
        guard let text = lastNameField.text, lastNameField.hasText else {
            lastNameErrorInlineLabel.text = fieldIsRequiredMessage
            handleColor(of: lastNameField, hasError: true)
            return false
        }
        
        guard !checkIfFieldHasNumber(text) else{
            lastNameErrorInlineLabel.text = "This field must have letters only"
            handleColor(of: lastNameField, hasError: true)
            return false
        }
        
        handleColor(of: lastNameField, hasError: false)
        lastNameErrorInlineLabel.text = ""
        return true
    }
    
    //mobile validation
    private func mobileValidation() -> Bool{
        guard let text = mobileField.text, mobileField.hasText else {
            mobileErrorInlineLabel.text = fieldIsRequiredMessage
            handleColor(of: mobileField, hasError: true)
            return false
        }
        
        guard checkIfFieldHasNumber(text) else{
            mobileErrorInlineLabel.text = "This field must have numbers only"
            handleColor(of: mobileField, hasError: true)
            return false
        }
        
        if text.count == 11 {
            if (text.prefix(2)=="01"){
                print(text)
            } else {
                mobileErrorInlineLabel.text = "Please enter a valid mobile number"
                handleColor(of: mobileField, hasError: true)
                return false
            }
        }
        
        if text.count == 10 {
            if (text.prefix(1)=="1"){
                print(text)
            } else {
                mobileErrorInlineLabel.text = "Please enter a valid mobile number"
                handleColor(of: mobileField, hasError: true)
                return false
            }
        }
        
        guard text.count == 11 || text.count == 10 else {
            mobileErrorInlineLabel.text = "Please enter a valid mobile number"
            handleColor(of: mobileField, hasError: true)
            return false
        }
        
        handleColor(of: mobileField, hasError: false)
        mobileErrorInlineLabel.text = ""
        return true
    }
    
    //email validation
    private func emailValidation() -> Bool{
        guard let text = emailField.text, emailField.hasText else {
            emailErrorInlineLabel.text = fieldIsRequiredMessage
            handleColor(of: emailField, hasError: true)
            return false
        }
        
        guard checkEmailConfirmation(emailAddress: text) else{
            emailErrorInlineLabel.text = "Invalid email"
            handleColor(of: emailField, hasError: true)
            return false
        }
        
        handleColor(of: emailField, hasError: false)
        emailErrorInlineLabel.text = nil
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

// MARK: Check for the fields
extension EditPersonalInfoVC{
    
    private func selectedAgeValidation() -> Bool{
        
        guard let _ = SelectedAge else {
            ageErrorInlineLabel.text = fieldIsRequiredMessage
            handleColor(of: selectedAgeView, hasError: true)
            return false
        }
        ageErrorInlineLabel.text = ""
        handleColor(of: selectedAgeView, hasError: false)
        return true
    }
    
    
    private func handleColor(of view: UIView, hasError: Bool){
        if hasError{
            view.layer.borderColor = redColor.cgColor
        }else{
            view.layer.borderColor = lightColor.cgColor
        }
    }
    
}


// MARK: UIImagePickerControllerDelegate , UINavigationControllerDelegate
extension EditPersonalInfoVC: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func addImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.accessibilityLanguage = LanguageManger.shared.currentLanguage.rawValue
        let actionsheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                imagePickerController.allowsEditing = true
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("camera is not available")
            }
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage{
            picker_Image = editedImage
        }else if let originalImage = info[.originalImage] as? UIImage{
            picker_Image = originalImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

