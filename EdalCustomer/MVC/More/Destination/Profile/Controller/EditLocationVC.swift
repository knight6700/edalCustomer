//
//  EditLocationVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/12/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import GoogleMaps
class EditLocationVC: UIViewController {

    @IBOutlet weak var selectCityView: UIView!
    @IBOutlet weak var selectDistrictView: UIView!
    @IBOutlet weak var selectCityButton: UIButton!
    @IBOutlet weak var selectDistrictButton: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
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
    var customer: Customer?
    // MARK: Properties
    private let redColor = UIColor(red: 207/255, green: 16/255, blue: 41/255, alpha: 1)
    private let lightColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    private var fieldIsRequiredMessage = "This field is required".localize()
    
    var selectedLocation: SelectedLocation?{
        didSet{
            locationDistrictLabel.text = selectedLocation?.address
            locationAddress = selectedLocation?.address ?? ""
            longitude = selectedLocation?.longitude ?? 0.0
            latitude = selectedLocation?.latitude ?? 0.0
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
        self.handleNavigationBars()
        //configuration()
        lookUpCities()
        setupUI()
        guard let customer = customer else {
            return
        }
        let location = SelectedLocation(address: customer.location, latitude: Double(customer.latitude) ?? 0.0, longitude: Double(customer.longitude) ?? 0.0)
        addMarker(location: location )
        // Do any additional setup after loading the view.
    }
    
    
    // setupUI: to setup data or make a custom design
    private func setupUI(){
        mapView.cornerRadius = 10
        mapView.layer.masksToBounds = true
        let light = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        selectCityView.roundView(withCorner: 4, borderColor: light, borderWidth: 0.5)
        selectDistrictView.roundView(withCorner: 4, borderColor: light, borderWidth: 0.5)
       // locationView.roundView(withCorner: 4, borderColor: light, borderWidth: 0.5)
    }
    
    
    // update CUstomer location Getting from APIs
    func updateCustomerLocation(){
        guard let districtId = locationDistrictId else {return}
        guard let locationAddress = locationAddress else {return}
        guard let longitude = longitude else {return}
        guard let latitude  =  latitude else {return}
        
        let services = ProfileServices()
        services.updateCustomerAddress(districtId: districtId, location: locationAddress, latitude: latitude, longitude: longitude) { [weak self] (error, data) in
            if let error = error {
                self?.alertUser(title: "", message: error)
                return
            }
            guard let _ = data else {return}
            self?.showToast(message: "Location Update Successfully")
            self?.navigationController?.popViewController(animated: true)
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
    
    func lookUpCities() {
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
    
    @IBAction func onTappedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTappedSelectCityButton(_ sender: UIButton) {
        let presnter = AuthPresenter(vc: self)
        presnter.present(.lookUpPopUp(type: .selectCity, lookUpAll: lookUpAll, lookUpDistricts: nil))
        
        selectDistrictButton.setTitle("Select District", for: .normal)
        let _ = selectedDistrictValidation()

        
    }
    
    @IBAction func onTappedSelectDistrict(_ sender: UIButton) {
        guard let city = selectedCity else {
            self.alertUser(title: "", message: "please select city")
            return
        }
        lookupDistricts(withCityId: city.id!)
    }
    
    @IBAction func onTappeDropNewLOcation(_ sender: UIButton) {
        let mapNavigator = MapNavigator(nav: self.navigationController)
        mapNavigator.navigate(to: .mapVC(from: self))
    }
    
    @IBAction func onTappedSaveButton(_ sender: UIButton) {
        updateCustomerLocation()
    }
    func addMarker(location: SelectedLocation) {
        location.latitude = Double(location.latitude)
        location.longitude = Double(location.longitude)
        
        let providerTitle = customer?.first_name ?? ""
        let providerMarker = GMSMarker()
        providerMarker.icon = UIImage(named: "pinblue")
        providerMarker.position = CLLocationCoordinate2D(latitude: location.latitude , longitude: location.longitude)
        providerMarker.title = providerTitle
        providerMarker.snippet = "Hey, this is \(customer?.first_name ?? "")"
        providerMarker.map = mapView
        // Center camera to marker position
        mapView.camera = GMSCameraPosition.camera(withTarget: providerMarker.position, zoom: 8)
        mapView.layer.cornerRadius = 10
        mapView.layer.masksToBounds = true
       // providerMarker[providerTitle] = providerMarker
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

