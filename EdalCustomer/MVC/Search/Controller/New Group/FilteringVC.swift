//
//  FilteringVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/2/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import GoogleMaps
//import RangeSeekSlider
struct FilterModel {
    var categoryId: Int?
    var maxRange: Int?
    var minRange: Int?
    var ratingFrom: Int?
    var ratingTo: Int?
    var location: Int?
    
}
protocol FilteringVCDelegate {
    func onTappedSaveFilterData(categoryId: Int?, maxRange: Int?, minRange: Int?, ratingFrom: Int?, ratingTo: Int?, farLocation: Int?)
}
class FilteringVC: UIViewController {

    
    @IBOutlet weak var indicatorCategoriesImageView: UIImageView!
    
    @IBOutlet weak var indicatorRatingImageView: UIImageView!
    
    var categories: Categories?
    var paginationCategoriesData = [PaginatedCategories]()
    var categoriesTotalpages: Int = 1
    var categoriesCurrentPage: Int = 1
    var categoryId: Int?
    var maxRange: Int?
    var minRange: Int?
    var ratingFrom: Int?
    var ratingTo: Int?
    var delegate: FilteringVCDelegate?
    @IBOutlet weak var ratingButon: UIButton!
    @IBOutlet weak var categoriesButton: UIButton!
    
    @IBOutlet weak var googleMapView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var locationKMSlider: UISlider!
    @IBOutlet weak var rangeSeekSlider: RangeSeekSlider!
    
    @IBOutlet weak var radiusLabel: UILabel!
    // var categories: Categories?
    var circle: GMSCircle!
    var centerMapCoordinate:CLLocationCoordinate2D!
    var SelectedCategory: CategoriesData?{
        didSet{
            print("categories id", SelectedCategory?.id)
            categoriesButton.setTitle(SelectedCategory?.name, for: .normal)
            categoryId = SelectedCategory?.id
        }
    }
    var location = SelectedLocation()
    
    let radiusSliderStep: Float = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("total",categoriesTotalpages)
        rangeSeekSlider.delegate = self
        loadMoreCategories()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addMarkerForPostion()
        addCircle(radius: 10000)
    }
    
    func addMarkerForPostion() {
        let providerTitle = "Kelany"
        let providerMarker = GMSMarker()
        providerMarker.icon = UIImage(named: "pinblue")
        location.latitude = Defaults.Latitude
        location.longitude = Defaults.Longitude
        // Google Map View Setup
        providerMarker.position = CLLocationCoordinate2D(latitude: location.latitude , longitude: location.longitude)
        providerMarker.title = providerTitle
        providerMarker.snippet = "Hey, this is \(providerTitle)"
        providerMarker.map = mapView
        // Center camera to marker position
        mapView.camera = GMSCameraPosition.camera(withTarget: providerMarker.position, zoom: 8)
    }
 
    func addCircle(radius: Double) {
        
        let circleCenter = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        circle = GMSCircle(position: circleCenter, radius: radius)
        
        circle.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        circle.strokeColor = .gray
        circle.strokeWidth = 0.5
        circle.map = mapView
    }
    
    func setupUI(){
        rangeSeekSlider.selectedMinValue = 150
        rangeSeekSlider.selectedMaxValue = 500
        categoriesButton.roundView(withCorner: 4.0, borderColor: UIColor.init(red: 233/255, green: 233/255, blue: 233/255, alpha: 1.0), borderWidth: 1.0)
        ratingButon.roundView(withCorner: 4.0, borderColor: UIColor.init(red: 233/255, green: 233/255, blue: 233/255, alpha: 1.0), borderWidth: 1.0)
        
        getIndicatorTintColor(image: indicatorRatingImageView)
        getIndicatorTintColor(image: indicatorCategoriesImageView)
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func radiusSliderDidChangeValue(_ sender: UISlider) {
        if circle.radius != nil {
           // circle.
        }
        circle.radius = CLLocationDistance(locationKMSlider.value*1000)
        let value = Int(locationKMSlider.value)
        let string = "Within \(value) km of you"
        kmLabel.text = string
    }
    
    //MARK: fetchMoreCategories
    func loadMoreCategories(){
        
        if categoriesCurrentPage == self.categoriesTotalpages {
            getAllCategories(for: categoriesCurrentPage)
            self.hideLoading()
            return
        }
        if categoriesCurrentPage > self.categoriesTotalpages {
            self.hideLoading()
            return
        }
        while categoriesCurrentPage < categoriesTotalpages {
            if paginationCategoriesData.count > 0 {
                print("go to get more categories")
                getAllCategories(for: categoriesCurrentPage)
                categoriesCurrentPage += 1
                print("page:\(categoriesCurrentPage)")
            }
        }
    }
    
    func getAllCategories(for page: Int) {
        self.showLoading()
        let services = CategoriesServices()
        services.getAllCategories(for: page, completion: { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let _data = data else{return}
            self.categories = _data.categories
            
        })
    }

    @IBAction func onTappedCategories(_ sender: Any) {
        let presenter = AuthPresenter(vc: self)
        if categories != nil
        {
        presenter.present(.searchLookUpPopUp(type: .selectCategory, searchlookUpPopup: categories!))
        }
        else
        {
            self.alertUser(title: "Error", message: "No records found")

        }
    }
    
    @IBAction func onTappedRatingButton(_ sender: UIButton) {
       // let ratingArray = ["1-5", "2-5", "3-5", ]
        let alert = UIAlertController(title: "", message: "Rating Star", preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("action")
           alert.dismiss(animated: true, completion: nil)
        }
        
        let firstButton = UIAlertAction(title: "1 - 5", style: .default) { (action) in
            self.ratingFrom = 1
            self.ratingTo = 5
            self.ratingButon.setTitle("1 - 5", for: .normal)
            print("ok action")
        }
        let secondButton = UIAlertAction(title: "2 - 5", style: .default) { (action) in
            self.ratingFrom = 2
            self.ratingTo = 5
            self.ratingButon.setTitle("2 - 5", for: .normal)
            print("ok action")
        }
        let thirdButton = UIAlertAction(title: "3 - 5", style: .default) { (action) in
            self.ratingFrom = 3
            self.ratingTo = 5
            self.ratingButon.setTitle("3 - 5", for: .normal)
            print("ok action")
        }
        let fourthButton = UIAlertAction(title: "4 - 5", style: .default) { (action) in
            self.ratingFrom = 4
            self.ratingTo = 5
            self.ratingButon.setTitle("4 - 5", for: .normal)
            print("ok action")
        }
        alert.addAction(cancelButton)
        alert.addAction(firstButton)
        alert.addAction(secondButton)
        alert.addAction(thirdButton)
        alert.addAction(fourthButton)
        
        present(alert, animated: true, completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func getIndicatorTintColor(image: UIImageView?){
        guard let imageView = image else {
            return
        }
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.init(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0)
    }
    @IBAction func onTappedSave(_ sender: UIBarButtonItem) {
//        guard let categoryID = categoryId else {return}
        let min = rangeSeekSlider.selectedMinValue
        let max = rangeSeekSlider.selectedMaxValue
       
        delegate?.onTappedSaveFilterData(categoryId: categoryId, maxRange: Int(max), minRange: Int(min), ratingFrom: ratingFrom, ratingTo: ratingTo, farLocation: Int(locationKMSlider!.value/1000))
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onTappedReset(_ sender: UIBarButtonItem) {
        self.rangeSeekSlider.selectedMinValue = 150.0
        self.rangeSeekSlider.selectedMaxValue = 500.0
        
        categoriesButton.setTitle(categories?.data?[0].name, for: .normal)
        ratingButon.setTitle("1 - 5", for: .normal)
    }
    

}


extension FilteringVC: SearchLookUpDataSource{
    func categorySelectedWith(category: CategoriesData) {
        print("Customer with selected categories \(category)")
        self.SelectedCategory = category
    }
    
}

// MARK: - RangeSeekSliderDelegate
extension FilteringVC: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}

