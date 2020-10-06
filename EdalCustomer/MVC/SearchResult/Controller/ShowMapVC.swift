//
//  ShowMapVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/3/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import GoogleMaps
import Cosmos

class ShowMapVC: UIViewController {
    var providerServicesData = [HomeProvidersDatum]()

//    var providerServicesData = [ProviderUserModel]()
    var ProviderMarkerDict: [String: GMSMarker] = [:]
    private let locationManager = CLLocationManager()
    var lat: String?
    var long: String?
    var location = SelectedLocation()
    //var ProviderMarkerDict: [String: GMSMarker] = [:]

    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleNavigationBar: UILabel!
    @IBOutlet weak var providerInfoView: UIView!
    @IBOutlet weak var providerImageView: UIImageView!
    @IBOutlet weak var ProviderTitleLabel: UILabel!
    @IBOutlet weak var providerSubCatNameLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var providerRatingView: CosmosView!
    @IBOutlet weak var providerReviewsLabel: UILabel!
    @IBOutlet weak var providerDataView: UIView!
    @IBOutlet weak var providerMinValueLabel: UILabel!
    @IBOutlet weak var providerMaxValueLabel: UILabel!
    
    @IBOutlet weak var providerFavButton: UIButton!
    var image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        image = UIImage(named: "faviconUn")?.withRenderingMode(.alwaysTemplate)
          providerFavButton.setImage(UIImage(named: "faviconUn.png"), for: .normal)
        providerFavButton.tintColor = UIColor.black
//       self.title = "Make Up"
//        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
//        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
//        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
//        //Customise the way you want:
//        let backBarButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:Selector(("back:")))
//        backBarButton.tintColor = .white
//        self.navigationItem.leftBarButtonItem = backBarButton
        setupUI()
        mapView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        providerDataView.isHidden = true
        providerFavButton.setImage(#imageLiteral(resourceName: "faviconUn"), for: .normal)
        providerDataView.roundView(withCorner: 8.0)
        providerImageView.roundView(withCorner: 7.0)
        print(providerServicesData)
        navigationBar.backgroundColor = UIColor.blueColor()
        titleNavigationBar.text = "Providers"
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToProviderDetails(sender:)))
        providerInfoView.addGestureRecognizer(tapGestRecognizer)
    }
    
    func back(){
        // Go back to the previous ViewController
       // Router().toProviderServicesVC()
        
        dismiss(animated: true, completion: nil)
    }
    @objc func goToProviderDetails(sender: UITapGestureRecognizer) {
        print("View Tapped")
        let storyBoard: UIStoryboard = UIStoryboard(name: "BusinessProfileSB", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProviderDetailsVC") as! ProviderDetailsVC
        self.present(newViewController, animated: true, completion: nil)
        
//        let navigator = SearchResultNavigator(nav: self.navigationController)
//        navigator.navigate(to: .providerDetails())
    }

    @IBAction func onTappedFavButton(_ sender: UIButton) {
        let services = FavoriteProviderServices()
        print()
        if providerFavButton.imageView?.image == #imageLiteral(resourceName: "faviconUn") {
            services.updateFavoriteProvider(withProviderId: providerFavButton.tag , favorite: 1) { (error, data) in
                print(self.providerFavButton.tag)
                if let error = error {
                    self.alertUser(title: "", message: error)
                    return
                }
                
                guard let _ = data else {return}
                self.providerFavButton.setImage(#imageLiteral(resourceName: "faviconact"), for: .normal)
            }
        } else {
            services.updateFavoriteProvider(withProviderId: providerFavButton.tag , favorite: 0) { (error, data) in
                if let error = error {
                    self.alertUser(title: "", message: error)
                    return
                }
                
                guard let _ = data else {return}
                
                self.providerFavButton.setImage(self.image, for: .normal)
            }
        }
    }
    
    @IBAction func onTappedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {

    self.navigationController?.setNavigationBarHidden(false, animated: true)
        addMarkers()
        
    }
    
    func addMarkers(){
        print()
        print()
        print(providerServicesData)
        for index in 0..<providerServicesData.count-1 {
            if let lat = providerServicesData[index].latitude {
             if !lat.isEmpty {
                 location.latitude =  Double(lat)!
                }
            }

          if let lng = providerServicesData[index].longitude {
            if !lng.isEmpty {
                    location.longitude = Double(lng)!
                }
            }
            let providerTitle = providerServicesData[index].businessName
            let providerMarker = GMSMarker()
            providerMarker.icon = UIImage(named: "pinblue")
            providerMarker.position = CLLocationCoordinate2D(latitude: location.latitude , longitude: location.longitude)
            providerMarker.title = providerTitle
            providerMarker.snippet = "Hey, this is \(providerTitle)"
            providerMarker.map = mapView
            ///medhat commented as it rpoduce error
            //ProviderMarkerDict[providerTitle] = providerMarker
            // Center camera to marker position
            mapView.camera = GMSCameraPosition.camera(withLatitude: 26.494184, longitude: 29.871903, zoom: 5.5)
        }
    }
    
}

extension ShowMapVC: GMSMapViewDelegate {
    func changeMarkerImage() {
        mapView.clear()
        for (key, _) in ProviderMarkerDict {
           // ProviderMarkerDict.values(forKey: key)
            ProviderMarkerDict[key]?.icon = UIImage(named: "pinblue")
            ProviderMarkerDict[key]?.map = mapView
            
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("Tapped Done!")
        changeMarkerImage()
      print(marker.position)
        marker.icon = UIImage(named: "pinorange")
        // mapView.selectedMarker = marker
        let markerlat = String(marker.position.latitude)
        let markerlong = String(marker.position.longitude)
        for index in 0..<providerServicesData.count-1 {
           // print(markerTitle)
            print(providerServicesData[index].businessName)
            if markerlat == providerServicesData[index].latitude && markerlong == providerServicesData[index].longitude {
                let bgImage = URL(string: providerServicesData[index].bgImage!)
                print("image_url:\(String(describing: bgImage))")
              providerImageView.sd_setImage(with: bgImage)
              providerDataView.isHidden = false
              providerFavButton.isHidden = false
                ProviderTitleLabel.text =  providerServicesData[index].businessName
                providerSubCatNameLabel.text = providerServicesData[index].subCategoryName
                providerRatingView.rating = Double(providerServicesData[index].rate!)/5.0
                providerReviewsLabel.text = "\(providerServicesData[index].raters)"
                providerMaxValueLabel.text = "\(providerServicesData[index].maxValue)"
                providerMinValueLabel.text = "\(providerServicesData[index].minValue)"
                //get providerid
                providerFavButton.tag = providerServicesData[index].id!
                print("providerFavButton.tag",providerFavButton.tag)
                if providerServicesData[index].favorite == false {
                    print("unactive")
                   providerFavButton.setImage(self.image, for: .normal)
                   // providerFavButton.tintColor = .gray
                   // providerFavButton.setImage(UIImage(name:"faviconact"), for: .normal)
                } else {
                    print("active")
                    providerFavButton.setImage(UIImage(named: "faviconact"), for: .normal)
                }
                
              //  return true
            } else {
                print("not Found")
            }
        }
        
        return true
    }
}
