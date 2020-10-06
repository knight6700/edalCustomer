//
//  MapVC.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/26/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

protocol SelectLocationDataSource {
    func locationIsSelected(with location: SelectedLocation)
}

class MapVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var searchHereButton: UIButton!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var droppedPinLabel: UILabel!
    
    // MARK: Properties
    var locationManager: CLLocationManager!
    var centeredMarker: GMSMarker!
    var selectedLocation: SelectedLocation?{
        didSet{ updateLocation() }
    }

    enum SelectLocationMood {
        case search
        case droopedPin
    }
    
    var selectLocationMood = SelectLocationMood.droopedPin
    var selectLocationDelegate: SelectLocationDataSource?
   
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // handleLocalization()
        initLocationManager()
        configuration()
        setupUI()
        creatMap(withLocation: selectedLocation)
    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    func configuration(){

    }
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
        searchHereButton.addShadow(withCorner: 0)
        addressView.addShadow(withCorner: 0)
        saveButton.roundView(withCorner: saveButton.frame.height/2, borderColor: .lightGray, borderWidth: 1)
    }
    
    // handleLocalization: to handle ar & en for the design
    func handleLocalization(){
        self.title = "Map_Title".localize()
        droppedPinLabel.text = "Map_droppedPinLabel".localize()
        searchHereButton.setTitle("Map_searchHereButton".localize(), for: .normal)
        saveButton.setTitle("Map_saveButton".localize(), for: .normal)
    }
    
    func creatMap(withLocation location: SelectedLocation?){
        // Create a map.
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        
        guard let location = location else {return}
        let lat = location.latitude
        let long = location.longitude
        
        mapView.camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 0)
        handleMarker(withLocation: location)
    }
    
    func handleMarker(withLocation location: SelectedLocation?){
        guard let location = location else {return}
        let lat = location.latitude
        let long = location.longitude
        
        guard centeredMarker != nil else {
            // create a new marker
            let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            centeredMarker = GMSMarker(position: position)
            centeredMarker.isDraggable = true
            centeredMarker.map = self.mapView
            centeredMarker.icon = UIImage(named: "pinmap")
            centeredMarker.position = position
            updateCamera(withLat: lat, andLong: long, zoom: 15)
            return
        }
        
        // update the centered marker position to be compatable with camira position
        centeredMarker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    func updateCamera(withLat lat: Double, andLong long: Double, zoom: Float){
        let _camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: zoom)
        let camera = GMSCameraUpdate.setCamera(_camera)
        mapView.moveCamera(camera)
    }

    func updateLocation(){
        guard let location = selectedLocation else { return }
        let lat = location.latitude
        let long = location.longitude
        let address = location.address
        print("selected lat: \(lat)")
        print("selected lat: \(long)")
        self.addressLabel.text = address
        handleMarker(withLocation: location)
    }
    
    func presentPlacePickerController(){
        let placePickerController = GMSAutocompleteViewController()
        placePickerController.delegate = self
        present(placePickerController, animated: true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func onTapSearchHere(_ sender: UIButton) {
        // search mood activated
        selectLocationMood = .search
        presentPlacePickerController()
    }
    
    @IBAction func onTapSave(_ sender: UIButton) {
        guard let location = selectedLocation else { return }
        selectLocationDelegate?.locationIsSelected(with: location)
        self.navigationController?.popViewController(animated: true)
    }

}

extension MapVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress ?? "")")
        print("place coaardinates: \(place.coordinate)")
        
        dismiss(animated: true) {
            let address = place.formattedAddress ?? ""
            let lat = place.coordinate.latitude
            let long = place.coordinate.longitude
            // camera will be updated in search mood only
            self.updateCamera(withLat: lat, andLong: long, zoom: 15)
            self.selectedLocation = SelectedLocation(address: address, latitude: lat, longitude: long)
        }
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // dropped pin mood activated
        selectLocationMood = .droopedPin
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

extension MapVC: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        guard centeredMarker != nil else {return}
        guard selectLocationMood == .droopedPin else {
            // droppedPin mood activated
            selectLocationMood = .droopedPin
            return
        }
        
        // ensuring that the api is not called at search mood
        self.reverseGeocodeCoordinate(withLocation: position.target)
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        guard centeredMarker != nil else {return}
        centeredMarker.position = position.target
    }
    
    private func reverseGeocodeCoordinate(withLocation location: CLLocationCoordinate2D) {
        let services = MapServices()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        services.reverseGeocodeCoordinate(withLocation: location) { (error, location) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let _error = error {
                self.alertUser(title: "", message: _error)
                return
            }
            
            guard let _location = location else { return }
            self.selectedLocation = _location
        }
    }
    
}

extension MapVC: CLLocationManagerDelegate{
    
    func initLocationManager(){
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        self.locationManager.stopUpdatingLocation()
        let lat = location.latitude
        let long = location.longitude
        print("\n//////////////////////////////////////")
        print("user current locations in locationManager = \(lat) \(long)")
        print("//////////////////////////////////////\n")
        self.reverseGeocodeCoordinate(withLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\n//////////////////////////////////////")
        print("locationManager didFailWithError: \(error.localizedDescription)")
        print("//////////////////////////////////////\n")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard CLLocationManager.locationServicesEnabled() else {
            alertUser(title: "oops!", message: "Location services are not enabled, please make sure to enable it")
            return
        }
        
        switch status {
        case .notDetermined, .restricted, .denied:
            print("here it is: notDetermined, restricted, denied")
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("authorizedAlways, authorizedWhenInUse")
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        }
    }
}

