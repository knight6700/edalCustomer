//
//  PersonalInfoVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/11/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import GoogleMaps
class PersonalInfoVC: UIViewController {

    //MARK:- properies
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    @IBOutlet weak var BusinessLocationLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    //MARK:- Outlets
    private let locationManager = CLLocationManager()
    var lat: String?
    var long: String?
    var location = SelectedLocation()
    var customer: Customer?
    //MARK:- Override Methods
    
    //MARK:- Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCustomerInfo()
        handleNavigationBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let customer = customer {
            mapView.settings.setAllGesturesEnabled(false)
            addMarker(for: customer)
        }
        
    }
    
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
    
   
    private func getCustomerInfo(){
        let services = ProfileServices()
        self.showLoading()
        services.getCustomerPersonalInfo {(error, data) in
            self.hideLoading()
            if let error = error {
                self.alertUser(title: "", message: error)
                return
            }
            
            guard let customer = data?.default_response.customer else {return}
          self.customer = customer
            print("////////////////customer data ////////////////////")
            print(customer)
 
            
                Defaults.saveUserData(with: customer)
                self.updateUIWithCustomerData(for: customer)
                self.addMarker(for: customer)
        }
    }
    
    
    func updateUIWithCustomerData(for customer: Customer){
        
        profileImageView.addImage(withImage: customer.image, andPlaceHolder: "")
        profileNameLabel.text = customer.first_name
        profileEmailLabel.text = customer.email
        firstNameLabel.text = customer.first_name
        lastNameLabel.text = customer.last_name
        mobileLabel.text = customer.mobile
        emailLabel.text = customer.email
        if customer.gender == 1 {
          genderLabel.text = "Male"
        }else {
           genderLabel.text = "Female"
        }
        ageLabel.text = customer.age.title
        addressLabel.text = customer.location
    }
    
    func addMarker(for customer: Customer) {
        location.latitude = Double(customer.latitude)!
        location.longitude = Double(customer.longitude)!
        
        let providerTitle = customer.first_name
        let providerMarker = GMSMarker()
        providerMarker.icon = UIImage(named: "pinblue")
        providerMarker.position = CLLocationCoordinate2D(latitude: location.latitude , longitude: location.longitude)
        providerMarker.title = providerTitle
        providerMarker.snippet = "Hey, this is \(providerTitle)"
        providerMarker.map = mapView
        // Center camera to marker position
        mapView.camera = GMSCameraPosition.camera(withTarget: providerMarker.position, zoom: 8)
       // providerMarker[providerTitle] = providerMarker
    }

    
    @IBAction func onTappedEditLocation(_ sender: UIButton) {
        let navigator = ProfileNavigator(nav: self.navigationController)
        navigator.navigate(to: .editLocation)
    }
    
    @IBAction func onTappedBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTappedEditPersonalInfo(_ sender: UIButton) {
        let navigator = ProfileNavigator(nav: self.navigationController)
        navigator.navigate(to: .editPersonalInfo)
    }
}
