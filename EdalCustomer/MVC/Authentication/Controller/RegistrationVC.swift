//
//  RegistrationVC.swift
//  edalCustomerTest
//
//  Created by Mohamed Kelany on 7/31/18.
//  Copyright © 2018 Mohamed Kelany. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {
    
    
    
    // MARK: Outlets
    @IBOutlet weak var selectedAgeView: UIView!
    @IBOutlet weak var selectCityView: UIView!
    @IBOutlet weak var selectDistrictView: UIView!
    @IBOutlet weak var locationView: UIView!
    
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var selectAgeButton: UIButton!
    @IBOutlet weak var selectCityButton: UIButton!
    @IBOutlet weak var selectDistrictButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    // Errors outlets
    @IBOutlet weak var firstNameErrorInlineLabel: UILabel!
    @IBOutlet weak var lastNameErrorInlineLabel: UILabel!
    @IBOutlet weak var mobileErrorInlineLabel: UILabel!
    @IBOutlet weak var emailErrorInlineLabel: UILabel!
    @IBOutlet weak var genderErrorInlineLabel: UILabel!
    @IBOutlet weak var ageErrorInlineLabel: UILabel!
    @IBOutlet weak var cityErrorInlineLabel: UILabel!
    @IBOutlet weak var districtErrorInlineLabel: UILabel!
    @IBOutlet weak var locationErrorInlineLabel: UILabel!

    // MARK: Properties
    private let redColor = UIColor(red: 207/255, green: 16/255, blue: 41/255, alpha: 1)
    private let lightColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    private var fieldIsRequiredMessage = "This field is required".localize()
    var email: String!
    var firstName: String!
    var lastName: String!
    
    var selectedLocation: SelectedLocation?{
        didSet{ locationButton.setTitle(selectedLocation?.address, for: .normal) }
    }
    var selectedCity: LookupAllDataModel?{
        didSet{ selectCityButton.setTitle(selectedCity?.name, for: .normal)}
    }
    
    var selectedDistrict: LookupAllDataModel?{
        didSet{ selectDistrictButton.setTitle(selectedDistrict?.title, for: .normal)
            districtErrorInlineLabel.text = ""
            handleColor(of: selectDistrictView, hasError: false)
        }
        
    }
    var SelectedAge: LookupAllDataModel?{
        didSet{ selectAgeButton.setTitle(SelectedAge?.title, for: .normal) }
    }
    
    var lookUpAll: LookupAllModel?
    var lookUpDistricts: LookupDistrictsModel?
    
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSoicalData()
        configuration()
        setupUI()

    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    private func configuration(){
         lookupAll()
        firstNameField.delegate = self
        lastNameField.delegate = self
        mobileField.delegate = self
        emailField.delegate = self

    }

    func checkSoicalData() {
        if firstName != " " {
            firstNameField.text = firstName
        } else { return }
        
        if lastName != " " {
            lastNameField.text = lastName
        } else { return }
 
        if email != " " {
            emailField.text = email
        } else { return }
    }
    func saveUserDataInDefaults(){
        // id -----> for all
        // title --> for business_sizes, years_of_experience, districts
        // name ---> for categories, cities
        // icon ---> for categories
        Defaults.FirstName = firstNameField.text ?? ""
        Defaults.LastName = lastNameField.text ?? ""
        Defaults.Mobile = mobileField.text ?? ""
        Defaults.Email = emailField.text ?? ""
        Defaults.AgeId = SelectedAge?.id ?? 0
        Defaults.Age = selectAgeButton.titleLabel?.text ?? ""
        Defaults.CityId = (selectedCity?.id)!
        Defaults.CityName = selectedCity?.name ?? ""
        Defaults.DistrictId = selectedDistrict?.id ?? 0
        Defaults.DistrictName = selectedDistrict?.title ?? ""
        Defaults.Location = selectedLocation!
        Defaults.Latitude = (selectedLocation?.latitude)!
        Defaults.Longitude = (selectedLocation?.longitude)!
        Defaults.termsAndConditions = lookUpAll?.terms ?? ""
        //Defaults.FirebaseToken = 
        Defaults.DeviceId = UIDevice.current.identifierForVendor!.uuidString
        if Defaults.SocialId != "" && Defaults.SocialProvider != "" && Defaults.SocialToken != "" {
            navigateToVerification()
        } else {
            navigateToPasswordVC()
            
        }
        print(Defaults.FirstName)
        print(Defaults.LastName)
        print(Defaults.Mobile)
        print(Defaults.Email)
        print(Defaults.Age)
        print(Defaults.CityId)
        print(Defaults.CityName)
        print(Defaults.DistrictId)
        print(Defaults.DistrictName)
        print(Defaults.Location)
        print(Defaults.Latitude)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        handleNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    

    // setupUI: to setup data or make a custom design
    private func setupUI(){
        firstNameField.roundView(withCorner: 4, borderColor: lightColor, borderWidth: 0.5)
        lastNameField.roundView(withCorner: 4, borderColor: lightColor, borderWidth: 0.5)
        mobileView.roundView(withCorner: 4, borderColor: lightColor, borderWidth: 0.5)
        emailField.roundView(withCorner: 4, borderColor: lightColor, borderWidth: 0.5)
        
        let light = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        selectedAgeView.roundView(withCorner: 4, borderColor: light, borderWidth: 0.5)
        selectCityView.roundView(withCorner: 4, borderColor: light, borderWidth: 0.5)
        selectDistrictView.roundView(withCorner: 4, borderColor: light, borderWidth: 0.5)
        locationView.roundView(withCorner: 4, borderColor: light, borderWidth: 0.5)
        nextButton.roundView(withCorner: nextButton.frame.height/2, borderColor: light, borderWidth: 0.5)
        
        // add left view ass apadding
        firstNameField.addLeftView()
        lastNameField.addLeftView()
        mobileField.addLeftView()
        emailField.addLeftView()
        
        //setting check box
        maleButton.setImage(UIImage(named: "done"), for: .normal)
        Defaults.Gender = 1
        femaleButton.setImage(UIImage(named: "uncheck"), for: .normal)
        
        

    }
    
    func handleNavigationBar(){
        
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
            self.lookUpAll = _data
        }
    }
    
    //using lookupDistrict APIs from Authentication Services class to get district
    func lookupDistricts(withCityId cityId: Int){
        let services = AuthenticationServices()
        showLoading()
        services.lookupDistricts(cityId: cityId) { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            
            guard let _data = data else{ return }
            self.lookUpDistricts = _data
            let presnter = AuthPresenter(vc: self)
            presnter.present(.lookUpPopUp(type: .selectDistrict, lookUpAll: nil, lookUpDistricts: self.lookUpDistricts))
        }
    }
    
  //using Validate User APIs from Authentication Services class
    private func validateUserData(withEmail email: String, mobile: String){
        let services = AuthenticationServices()
        showLoading()
        services.validateUserData(withEmail: email, mobile: mobile) { (error, errors,data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            
            if let errors = errors{
                if let emailError = errors["email"]{
                    self.emailErrorInlineLabel.text = emailError
                }
                if let mobileError = errors["mobile"]{
                    self.mobileErrorInlineLabel.text = mobileError
                }
                return
            }
            guard let data = data else{ return }
           // Defaults.code = data.code ?? 0
             self.saveUserDataInDefaults()
            
            
            
        }
    }

    
    // MARK: Actions
    func navigateToPasswordVC() {
        
        let isFirstNameValidate = firstNameValidation()
        let isLastNameValidate = lastNameValidation()
        let isMobileValidate = mobileValidation()
        let isEmailValidate = emailValidation()
        
        guard isFirstNameValidate, isLastNameValidate, isMobileValidate,
            isEmailValidate else{
                return
        }

        
        let navigator = AuthNavigator(nav: self.navigationController)
        navigator.navigate(to: .password)
    }
    func navigateToVerification() {
           let navigator = AuthNavigator(nav: self.navigationController)
           navigator.navigate(to: .verification(cameFrom: .normalRegisteration))
       }
    
    @IBAction func onTapNext(_ sender: UIButton) {

        let isFirstNameValidate = firstNameValidation()
        let isLastNameValidate = lastNameValidation()
        let isMobileValidate = mobileValidation()
        let isEmailValidate = emailValidation()

        
        guard isFirstNameValidate, isLastNameValidate, isMobileValidate,
            isEmailValidate else{
                return
        }
        

        let isSelectedAgeValidate = selectedAgeValidation()
        let isSelectedCityValidate = selectedCityValidation()
        let isSelectedDistrictValidate = selectedDistrictValidation()
        let isSelectedLocationValidate = selectedLocationValidation()

        
        guard isSelectedAgeValidate, isSelectedCityValidate, isSelectedDistrictValidate,
            isSelectedLocationValidate else{
                return
        }
        
        if mobileField.hasText{
            let isMobileValidate = mobileValidation()
            guard isMobileValidate else {return}
        }
        
        let email = emailField.text!
        let mobile = mobileField.text!
        validateUserData(withEmail: email, mobile: mobile)
    }

    
    @IBAction func onTapAge(_ sender: UIButton) {
        //guard let _ = SelectedAge?.id else {return}
        let presnter = AuthPresenter(vc: self)
        presnter.present(.lookUpPopUp(type: .selectAge, lookUpAll: lookUpAll, lookUpDistricts: nil))
        
    }
    
    @IBAction func onTapSelectCity(_ sender: UIButton) {
        let presnter = AuthPresenter(vc: self)
        presnter.present(.lookUpPopUp(type: .selectCity, lookUpAll: lookUpAll, lookUpDistricts: nil))
        
        selectDistrictButton.setTitle("Select District", for: .normal)
        let _ = selectedDistrictValidation()

    }
    
   
    @IBAction func onTapSelectDistrict(_ sender: UIButton) {
        guard let city = selectedCity else {
            self.alertUser(title: "", message: "please select city")
            return
        }
        lookupDistricts(withCityId: city.id!)

    }
    
    @IBAction func onTapLocation(_ sender: UIButton) {
        let navigator = MapNavigator(nav: self.navigationController)
        navigator.navigate(to: .mapVC(from: self))
    }
    
   var checked = true
    @IBAction func onTapMale(_ sender: UIButton) {
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
    
    @IBAction func onTapFemale(_ sender: UIButton) {
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
}

extension RegistrationVC: SelectLocationDataSource {
    func locationIsSelected(with location: SelectedLocation) {
        print("RegistrationVC with Location \(location)")
        self.selectedLocation = location
    }
}

extension RegistrationVC: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == firstNameField{
            let _ = firstNameValidation()
        }else if textField == lastNameField{
            let _ = lastNameValidation()
        }else if textField == mobileField{
            let _ = mobileValidation()
        }else if textField == emailField{
            let _ = emailValidation()
            textField.resignFirstResponder()
        }
    }
}

extension RegistrationVC: LookUpPopUpDataSource{
    
    func ageSelectedwith(age: LookupAllDataModel) {
        print("Customer with selectedAge \(age)")
        self.SelectedAge = age
    }
    
    func citySelectedWith(city: LookupAllDataModel) {
        print("Customer with selectedCity \(city)")
        self.selectedCity = city
    }
    
    func districtSelectedWith(district: LookupAllDataModel) {
        print("Customer with selectedDistrict \(district)")
        self.selectedDistrict = district
    }
    
}


// MARK: Check for the fields
extension RegistrationVC{
    
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
extension RegistrationVC{
   
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
    
    private func selectedCityValidation() -> Bool{
        
        guard let _ = selectedCity else {
        cityErrorInlineLabel.text = fieldIsRequiredMessage
            handleColor(of: selectCityView, hasError: true)
            return false
        }
        
        cityErrorInlineLabel.text = ""
        handleColor(of: selectCityView, hasError: false)
        return true
    }
    
    private func selectedDistrictValidation() -> Bool{
        if selectDistrictButton.currentTitle == "Select District" {
            districtErrorInlineLabel.text = fieldIsRequiredMessage
            handleColor(of: selectDistrictView, hasError: true)
            return false
        }
        
        
        return true
    }
    
    private func selectedLocationValidation() -> Bool{
        guard let _ = selectedLocation else {
            locationErrorInlineLabel.text = fieldIsRequiredMessage
            handleColor(of: locationView, hasError: true)
            return false
        }
        
        locationErrorInlineLabel.text = ""
        handleColor(of: locationView, hasError: false)
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

