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
    var providerServicesData: [ProvidersDatum]{
        return searchableResponse?.providers?.data ?? [ProvidersDatum]()
    }
    var searchableResponse: SearchableResponse?


//    var providerServicesData = [ProviderUserModel]()
    var ProviderMarkerDict: [String: GMSMarker] = [:]
    private let locationManager = CLLocationManager()
    var lat: String?
    var long: String?
    var location = SelectedLocation()
    var index: Int?
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
        guard let index = index else {
            return
        }
        let id = "ServiceItemDetailsViewController"
        let item = providerServicesData[index]

        let vc = Initializer.createViewController(storyBoard: .HomeSB, andId: id) as! ServiceItemDetailsViewController
        vc.subServiceId = item.id!
        vc.serviceItemDetailsModel = ServiceItemDetailsModel(imageUrl: item.image ?? "", name: item.businessName ?? "", images: [item.image ?? ""], type: item.categoryName ?? "",rate: Double(item.rate ?? 0), totalReview: item.raters ?? 0,isFavourite: item.favorite ?? false)
        vc.isSearchable = true
        let navigation = UINavigationController(rootViewController: vc)
        self.present(navigation, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
        guard providerServicesData.count > 0 else {return}
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
            providerMarker.snippet = "Hey, this is \(providerTitle ?? "")"
            providerMarker.map = mapView
            ///medhat commented as it rpoduce error
            ProviderMarkerDict[providerServicesData[index].businessName ?? ""] = providerMarker
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
        changeMarkerImage()
        marker.icon =  UIImage(named: "pinorange")
        // mapView.selectedMarker = marker
        let markerlat = String(marker.position.latitude)
        let markerlong = String(marker.position.longitude)
        for index in 0..<providerServicesData.count-1 {
           // print(markerTitle)
            if markerlat == providerServicesData[index].latitude && markerlong == providerServicesData[index].longitude {
                self.index = index
                let bgImage = URL(string: providerServicesData[index].bgImage!)
                print("image_url:\(String(describing: bgImage))")
                providerImageView.sd_setImage(with: bgImage)
                providerDataView.isHidden = false
                providerFavButton.isHidden = false
                ProviderTitleLabel.text =  providerServicesData[index].businessName
                providerSubCatNameLabel.text = providerServicesData[index].subCategoryName
                providerRatingView.rating = Double(providerServicesData[index].rate ?? 0)
                providerReviewsLabel.text = "\(providerServicesData[index].raters ?? 0)"
                providerMaxValueLabel.text = "\(providerServicesData[index].maxValue ?? 0)"
                providerMinValueLabel.text = "\(providerServicesData[index].minValue ?? 0)"
                //get providerid
                providerFavButton.tag = providerServicesData[index].id!
                print("providerFavButton.tag",providerFavButton.tag)
                if providerServicesData[index].favorite == false {
                    print("unactive")
                   providerFavButton.setImage(self.image, for: .normal)
                    providerFavButton.setImage(UIImage(named: "faviconact"), for: .normal)
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
