//
//  EditLocationVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/12/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class EditLocationVC: UIViewController {

    @IBOutlet weak var selectCityView: UIView!
    @IBOutlet weak var selectDistrictView: UIView!
    @IBOutlet weak var selectCityButton: UIButton!
    @IBOutlet weak var selectDistrictButton: UIButton!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    
    @IBOutlet weak var locationDistrictLabel: UILabel!
    var locationDistrictId: Int?
    var locationAddress: String?
    var longitude: Double?
    var latitude: Double?
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var cityErrorInlineLabel: UILabel!
    @IBOutlet weak var districtErrorInlineLabel: UILabel!
    // MARK: Properties
    private let redColor = UIColor(red: 207/255, green: 16/255, blue: 41/255, alpha: 1)
    private let lightColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    private var fieldIsRequiredMessage = "This field is required".localize()
    
    var selectedLocation: SelectedLocation?{
        didSet{
            locationDistrictLabel.text = selectedLocation?.address
           }
    }
    var selectedCity: LookupAllDataModel?{
        didSet{ selectCityButton.setTitle(selectedCity?.name, for: .normal)}
    }
    
    var selectedDistrict: LookupAllDataModel?{
        didSet{
            selectDistrictButton.setTitle(selectedDistrict?.title, for: .normal)
            locationDistrictId = selectedDistrict?.id
            districtErrorInlineLabel.text = ""
            handleColor(of: selectDistrictView, hasError: false)
        }
        
    }
    var lookUpAll: LookupAllModel?
    var lookUpDistricts: LookupDistrictsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configuration()
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    
    // setupUI: to setup data or make a custom design
    private func setupUI(){

        let light = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        selectCityView.roundView(withCorner: 4, borderColor: light, borderWidth: 0.5)
        selectDistrictView.roundView(withCorner: 4, borderColor: light, borderWidth: 0.5)
       // locationView.roundView(withCorner: 4, borderColor: light, borderWidth: 0.5)
    }
    
    func handleNavigationBar(){
        
    }
    
    // update CUstomer location Getting from APIs
    func updateCustomerLocation(){
        guard let districtId = locationDistrictId else {return}
        guard let locationAddress = locationAddress else {return}
        guard let longitude = longitude else {return}
        guard let latitude  =  latitude else {return}
        
        let services = ProfileServices()
//        services.updateCustomerAddress(districtId: districtId, location: locationAddress, latitude: latitude, longitude: longitude) { (error, data) in
//            if let error = error {
//                self.alertUser(title: "", message: error)
//                return
//            }
//
//            guard let data = data else {return}
//        }
        
        
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
//            self.lookUpDistricts = _data
//            let presnter = AuthPresenter(vc: self)
//            presnter.present(.lookUpPopUp(type: .selectDistrict, lookUpAll: nil, lookUpDistricts: self.lookUpDistricts))
        }
    }
    
    @IBAction func onTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTappedSelectCityButton(_ sender: UIButton) {
        
    }
    
    @IBAction func onTappedSelectDistrict(_ sender: UIButton) {
        
    }
    
    @IBAction func onTappeDropNewLOcation(_ sender: UIButton) {
        
    }
    
    @IBAction func onTappedSaveButton(_ sender: UIButton) {
        
    }
    

}

extension EditLocationVC: SelectLocationDataSource {
    func locationIsSelected(with location: SelectedLocation) {
        print("RegistrationVC with Location \(location)")
        self.selectedLocation = location
    }
}

extension EditLocationVC: LookUpPopUpDataSource {
   
    func ageSelectedwith(age: LookupAllDataModel) {
        return
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
extension EditLocationVC{
    
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
    
    private func handleColor(of view: UIView, hasError: Bool){
        if hasError{
            view.layer.borderColor = redColor.cgColor
        }else{
            view.layer.borderColor = lightColor.cgColor
        }
    }
    
}


