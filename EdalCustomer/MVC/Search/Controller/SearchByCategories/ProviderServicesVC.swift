//
//  ProviderServicesVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/30/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import SideMenu
import CoreLocation

class ProviderServicesVC: SlideMenuController {


    @IBOutlet weak var filterMenuNavBarItem: UIBarButtonItem!
    @IBOutlet weak var providerServicesTableView: UITableView!
    
    @IBOutlet weak var sortingButton: UIButton!
    @IBOutlet weak var trailingContainerConstrait: NSLayoutConstraint!
    @IBOutlet weak var leadingContainerConstraits: NSLayoutConstraint!
    
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var priceSlider: RangeSeekSlider!
    @IBOutlet weak var sideContainerView: UIView!
    var servicesId: Int?
    var providerServicesData = [ProvidersDatum] ()
    var searchableResponse: SearchableResponse?
    var providerServicesPaginationData = [HomeProvidersDatum]()
    var providerServiceTotalPages = 1
    let servicesSubCategories = ServicesSubCategoriesVC()
    var sideMenuShowing = true
    var categories: Categories?
    var paginationCategoriesData = [PaginatedCategories]()
     var categoryId: Int?
    var categoriesTotalpages: Int = 1
    var categoriesCurrentPage: Int = 1
    var providerTotalpages: Int = 1
    var providerCurrentPage: Int = 1
    var searchKeyword: String?
    var cityDistrict: Int?
    var date: String?
    var time: String?
    var minPrice: Int?
    var maxPrice: Int?
    var currentPage: Int?
    var locationRange: Int?
    var ratingFrom: Int?
    var ratingTo: Int?
    var sorting: Int?
    var defaultMinPrice: Int?
    var defaultMaxPrice: Int?
    //var locationRange: Int?
    var searchByCategory: Bool = false
     @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var providerServicesNavigator: UINavigationItem!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var categoriesButton: UIButton!
    @IBOutlet weak var indicatorCategoriesImageView: UIImageView!
    @IBOutlet weak var indicatorRatingImageView: UIImageView!
    var tabBarHeight: CGFloat?
    var highToLowPrice: Bool = false, lowToHighPrice: Bool = false, topRated: Bool = false, aToZ: Bool = false
    var currentOffsetX = 0
    var totalNumberOfItems = 0
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        return refresher
    }()
    var SelectedCategory: CategoriesData?{
        didSet{
            categoriesButton.setTitle(SelectedCategory?.name, for: .normal)
            categoryId = SelectedCategory?.id
        }
        willSet{
            showSideMenu()
        }
    }
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()

        noResultsView.isHidden = true
        tabBarHeight = self.tabBarController?.tabBar.frame.height
        providerServicesTableView.delegate = self
        providerServicesTableView.dataSource = self
        self.navigationController?.navigationBar.addSubview(sideMenuView)
        self.navigationController?.navigationBar.addSubview(blackView)
        servicesId = Defaults.servicesId
        Configuration()
        setupUI()
        setupSideMenu()
        providerServicesTableView.addSubview(refresher)
    }
    
    func setupLocationManager() {
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }

    func setupUI(){
        providerServicesTableView.estimatedRowHeight = 181.0
        providerServicesTableView.rowHeight = UITableView.automaticDimension
        getIndicatorTintColor(image: indicatorRatingImageView)
        getIndicatorTintColor(image: indicatorCategoriesImageView)
    }
    
    func getIndicatorTintColor(image: UIImageView?){
        guard let imageView = image else {
            return
        }
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.init(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0)
    }
    
    @objc func pullToRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
    
    func searchWithKeyWord(){
        
    }

    //MARK: configureCollectionView
    func Configuration() {
        providerServicesTableView.register(UINib.init(nibName: "RecommendedCell", bundle: nil), forCellReuseIdentifier: "RecommendedCell")
        providerServicesTableView.estimatedRowHeight = 189
         sortingButton.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        self.tabBarController?.tabBar.addSubview(sideMenuView)
        self.tabBarController?.tabBar.addSubview(blackView)
    }
   
    @IBAction func onTappedReset(_ sender: UIButton) {
        priceSlider.minValue = 150
        priceSlider.maxValue = 500
        categoriesButton.setTitle(categories?.data![0].name, for: .normal)
        
    }
    
    @IBAction func onTappedDoneButton(_ sender: UIButton) {
        guard let keyword = searchKeyword else {return}
        guard let minPrice = minPrice else {return}
        guard let maxPrice = maxPrice else {return}
        searchAndFilter(keyword: keyword, districtId: nil, time: nil, page: providerCurrentPage, date: nil, minPrice: minPrice, maxPrice: maxPrice, locationRange: nil, ratingFrom: nil, ratingTo: nil, categoryId: categoryId, sortingId: nil)
    }
    
    fileprivate func setupSideMenu() {
        SideMenuManager.default.menuPresentMode = .menuDissolveIn
        SideMenuManager.default.menuWidth = self.view.frame.width * 0.8
        SideMenuManager.default.menuFadeStatusBar = false
    }
    
    
    @IBAction func onTappedFilter(_ sender: UIBarButtonItem) {

        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "FilteringVC") as! FilteringVC
        SideMenuManager.default.menuRightNavigationController = UISideMenuNavigationController.init(rootViewController: menuVC)
            menuVC.delegate = self
        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
    }
    func configurationSideMenu() {
        sideMenuView.layer.zPosition=100
        blackView.isHidden=true
        sideMenuView.isHidden = true
        blackView.layer.zPosition=99
        blackView.frame.origin = CGPoint(x:0, y:-64)
        sideMenuView.frame.origin = CGPoint(x: 80, y: -64)
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(blackScreenTapAction(sender:)))
        blackView.addGestureRecognizer(tapGestRecognizer)
    }
    
    @objc func blackScreenTapAction(sender: UITapGestureRecognizer) {
        hideSideMenu()
    }

    @IBAction func OnTappedSideButton(_ sender: UIBarButtonItem) {
     handleSideMenu()
    }

    func showSideMenu(){
        let tabBarHeight = self.tabBarController?.tabBar.frame.height
        blackView.frame = CGRect(x: 0 ,y: -64, width: self.view.frame.width, height: self.view.frame.height+tabBarHeight!)
        sideMenuView.frame = CGRect(x: 80 ,y: -64, width: self.view.frame.width-80, height: self.view.frame.height+tabBarHeight!)
        self.navigationController?.navigationBar.layer.zPosition = -1
        self.blackView.isHidden=false
        self.sideMenuView.isHidden = false
        sideMenuView.slideInFromRight()
        sideMenuShowing = !sideMenuShowing
    }
    
    func hideSideMenu(){
        blackView.isHidden=true
        sideMenuView.isHidden = true
        sideMenuView.slideInToRight()
        sideMenuShowing = !sideMenuShowing
    }
    
    func handleSideMenu() {
        if sideMenuShowing {
            DispatchQueue.main.async {
                self.showSideMenu()
            }
           
        } else {
            DispatchQueue.main.async {
                self.hideSideMenu()
            }
        }
    }
    
    @IBAction func onTappedSorting(_ sender: UIButton) {
        let sortingVC = self.storyboard?.instantiateViewController(withIdentifier: "SortingPopupVC") as! SortingPopupVC
        sortingVC.delegate = self
        sortingVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.tabBarController?.present(sortingVC, animated: true) { () -> Void in
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                sortingVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationBar()
        if searchByCategory == true {
             loadMoreProviderServices()
        }else {
            searchAndFilter(keyword: searchKeyword ?? "", districtId: 1, time: time, page: providerCurrentPage, date: date, minPrice: nil, maxPrice: nil, locationRange: nil, ratingFrom: nil, ratingTo: nil, categoryId: nil, sortingId: nil)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    

    func handleNavigationBar(){
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.title = " "
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func seaarchMore(){
        if providerCurrentPage <= self.providerServiceTotalPages {
            searchAndFilter(keyword: searchKeyword, districtId: cityDistrict, time: time, page: providerCurrentPage, date: date, minPrice: minPrice, maxPrice: maxPrice, locationRange: locationRange, ratingFrom: ratingFrom, ratingTo: ratingTo, categoryId: categoryId, sortingId: sorting)
            providerCurrentPage += 1
            self.hideLoading()
            return
        }
        
    }
    
    func searchAndFilter(keyword: String?, districtId: Int?, time: String?,page: Int?, date: String?, minPrice: Int?, maxPrice: Int?,locationRange: Int?, ratingFrom: Int?, ratingTo: Int?, categoryId: Int?, sortingId: Int?){
        let services = SearchServices()
        self.showLoading()
        services.search(byKeyword: keyword, byDistrict: districtId, byDate: date, byTime: time, byPage: page, byMinPrice: minPrice, byMaxPrice: maxPrice, byLocationRange: locationRange, byCategoryId: categoryId, byRatingFrom: ratingFrom, byRatingTo: ratingTo, bySorting: sortingId, locationRange: locationRange) {[weak self] (error, data) in
            self?.hideLoading()
            if  error != "" {
                self?.alertUser(title: "", message: error ?? "")
                return
            }
            guard let data = data else {return}
            self?.searchableResponse = data
            self?.providerTotalpages = data.providers?.meta?.pagination?.totalPages ?? 0
            self?.providerServicesData = data.providers?.data ?? [ProvidersDatum]()
            print(self?.providerServicesData.count ?? 0)
            if self?.searchableResponse?.providers?.data?.count == 0 {
                self?.searchResultLabel.text = "Search results (No Results)"
                self?.providerServicesTableView.reloadData()
                self?.refresher.removeFromSuperview()
            } else {
                self?.totalNumberOfItems = data.providers?.meta?.pagination?.count ?? 0 * (data.providers?.meta?.pagination?.totalPages ?? 0)
                self?.searchResultLabel.text = "Search results (\(self?.totalNumberOfItems ?? 0))"
                self?.providerServicesTableView.reloadData()
            }

        }
    }
  

    func getproviderServices(currentPage: Int) {
        let services = SearchServices()
        self.showLoading()
        services.getProviderServices(by: servicesId!, by: currentPage, completion: {[weak self] (error, data) in
            self?.hideLoading()
            if let error = error{
                self?.alertUser(title: "", message: error)
                return
            }
            guard let data = data else{return}
            self?.searchableResponse = data
            self?.providerTotalpages = (data.providers?.meta?.pagination?.totalPages ?? 0)
            if self?.providerServicesData.count == 0 {
                self?.noResultsView.isHidden = true
                self?.searchResultLabel.text = "Search results (No Results)"
                self?.providerServicesTableView.reloadData()
            } else {
                self?.totalNumberOfItems = data.providers?.meta?.pagination?.perPage ?? 0 * (data.providers?.meta?.pagination?.totalPages ?? 0)
                self?.searchResultLabel.text = "Search results (\(self?.totalNumberOfItems ?? 0))"

                self?.providerServicesTableView.reloadData()
            }
        })
    }
    
    func gettotalPagesofProviderServices(){
        let services = SearchServices()
        services.getProviderServices(by: servicesId! , by: 1, completion: { (error, data) in
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let _data = data else{return}
            self.providerServiceTotalPages = _data.providers?.meta?.pagination?.totalPages ?? 0
            print(self.providerServiceTotalPages)
        })
    }
    
    
    
    //MARK: fetchMoreCategories
    func loadMoreProviderServices(){
        
        if providerCurrentPage <= self.providerServiceTotalPages {
            getproviderServices(currentPage: providerCurrentPage)
            providerCurrentPage += 1
            print("page:\(providerCurrentPage)")
            self.hideLoading()
            return
        }
    }
    

    

    func getAllCategories(for page: Int) {
       // self.showLoading()
        let services = CategoriesServices()
        services.getAllCategories(for: page, completion: { (error, data) in
           // self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let _ = data else{return}
            
        })
    }


        
    func formatPoints(num: Int) ->String{
        let thousandNum = num/1000
        let millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            if(thousandNum == thousandNum){
                return("\(thousandNum)k")
            }
            return("\(thousandNum)k")
        }
        if num > 1000000{
            if(millionNum == millionNum){
                return("\(millionNum)M")
            }
            return ("\(millionNum)M")
        }
        else{
            if(num == num){
                return ("\(num)")
            }
            return ("\(num)")
        }
        
    }
    
    @IBAction func onTappedCategoryButton(_ sender: UIButton) {
       hideSideMenu()
        let presenter = AuthPresenter(vc: self)
       
        presenter.present(.searchLookUpPopUp(type: .selectCategory, searchlookUpPopup: categories!))

    }
    
    @IBAction func onTappedRatingButton(_ sender: UIButton) {
    }
    
    @IBAction func onTappedShowMap(_ sender: UIButton) {
//        let presenter = SearchPresenter(vc: self)
//        presenter.present(.ShowOnMap(providerDetailsData: providerServicesData))
//        let storyboard = UIStoryboard.init(name: "SearchResultSB", bundle: nil)
//        let showMapVC = storyboard.instantiateViewController(withIdentifier: "ShowMapVC") as? ShowMapVC
//        let navShowMapVC: UINavigationController = UINavigationController(rootViewController: showMapVC!)
//        showMapVC?.providerServicesData = self.providerServicesData
//        self.present(navShowMapVC, animated: true, completion: nil)
        let storyboard = UIStoryboard.init(name: "SearchResultSB", bundle: nil)
        let showMapVC = storyboard.instantiateViewController(withIdentifier: "ShowMapVC") as! ShowMapVC
        
        // MARK: ToDO
//        showMapVC.providerServicesData = self.providerServicesData
       // sortingVC.delegate = self
        showMapVC.searchableResponse = searchableResponse
        showMapVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.tabBarController?.present(showMapVC, animated: true) { () -> Void in
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                showMapVC.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            })
        }

    }
}


//MARK:- Table View Data Source
extension ProviderServicesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if providerServicesData.count == 0 {
            providerServicesTableView.setNoData()
            return 0
        }else {
            providerServicesTableView.backgroundView = nil
            return providerServicesData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendedCell", for: indexPath) as? RecommendedCell else {
            return UITableViewCell()
        }
       // cell.recommendedDelegate = self
        cell.businessNameLabel.text = providerServicesData[indexPath.item].businessName
        let businessImage = URL(string: providerServicesData[indexPath.item].image!)
        print("image_url:\(String(describing: businessImage))")
        cell.businessImageView.sd_setImage(with: businessImage)
        cell.categoriesNameLabel.text = providerServicesData[indexPath.item].categoryName
        if providerServicesData[indexPath.item].imagesCount == 0 {
            cell.imagesCountLabel.text = "No Photos"
        }else {
            cell.imagesCountLabel.text = "\(providerServicesData[indexPath.item].imagesCount ?? 0) Photos"
        }
        
        cell.categoriesRateView.rating = Double(providerServicesData[indexPath.item].rate!)
        
        let bgImage = URL(string: providerServicesData[indexPath.item].bgImage!)
        print("image_url:\(String(describing: bgImage))")
        cell.bgImageView.sd_setImage(with: bgImage)
        cell.maxValuePriceLabel.text = formatPoints(num: providerServicesData[indexPath.item].maxValue!)
        cell.minValuePriceLabel.text = formatPoints(num: providerServicesData[indexPath.item].minValue!)
        if providerServicesData[indexPath.item].favorite == false {
            cell.favButton.setImage(#imageLiteral(resourceName: "faviconUn"), for: .normal)
        } else {
            cell.favButton.setImage(#imageLiteral(resourceName: "faviconact"), for: .normal)
        }
        
        return cell
    }
    
    
}
//MARK:- Table View Data Source
extension ProviderServicesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = providerServicesData[indexPath.item]
        // navigator.navigate(to: .serviceItemdetail())
        let id = "ServiceItemDetailsViewController"
        let vc = Initializer.createViewController(storyBoard: .HomeSB, andId: id) as! ServiceItemDetailsViewController
        vc.serviceItemDetailsModel = ServiceItemDetailsModel(imageUrl: item.image ?? "", name: item.businessName ?? "", images: item.images?.data?.map({$0.image ?? ""}) ?? [""], type: "SPA" ,rate: 4.0, totalReview: 50,isFavourite: true)
        vc.subServiceId = item.id!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ProviderServicesVC: ServicesSubCategoriesVCDelegate {
    func servicesIdChanged(id: Int?) {
        servicesId = id
    }
    
    
}

extension ProviderServicesVC: SearchLookUpDataSource{
    func categorySelectedWith(category: CategoriesData) {
        print("Customer with selected categories \(category)")
        self.SelectedCategory = category
       // self.categoryId = category.id
        
    }
   
}
extension ProviderServicesVC: SortingPopupVCDelegate {
    func onTappedSorttingItem(highToLowPrice: Bool, lowToHighPrice: Bool, topRated: Bool, aToZ: Bool) {
        self.highToLowPrice = highToLowPrice
        self.lowToHighPrice = lowToHighPrice
        self.topRated = topRated
        self.aToZ = aToZ
        if highToLowPrice == false {
            sorting = 1
            providerServicesData = providerServicesData.sorted(by: { (one, Two) -> Bool in
                return one.minValue ?? 0 > Two.minValue ?? 0
            })
        }
        if lowToHighPrice == false {
            sorting = 2
            providerServicesData = providerServicesData.sorted(by: { (one, Two) -> Bool in
                return one.minValue ?? 0 < Two.minValue ?? 0
            })
        }
        if topRated == false {
            sorting = 3
            providerServicesData = providerServicesData.sorted(by: { (one, Two) -> Bool in
                return one.rate ?? 0 > Two.rate ?? 0
            })
        }
        if aToZ == false {
            sorting = 4
            providerServicesData = providerServicesData.sorted(by: { (one, Two) -> Bool in
                return (one.businessName?.localizedCaseInsensitiveCompare(Two.businessName ?? "") == .orderedAscending)
            })
        }
        providerServicesTableView.reloadData()
    }
}


extension ProviderServicesVC: FilteringVCDelegate {
    
    func onTappedSaveFilterData(categoryId: Int?, maxRange: Int?, minRange: Int?, ratingFrom: Int?, ratingTo: Int?, farLocation: Int?) {
        if farLocation != nil {
              var index = 0
              providerServicesData.forEach { (provider) in
                  let cordinate = CLLocation(latitude: (CLLocationDegrees(exactly: Double(provider.latitude ?? "0") ?? 0) ?? 0.0), longitude: (CLLocationDegrees(exactly: Double(provider.latitude ?? "0") ?? 0) ?? 0.0))
                  providerServicesData[index].distance = (getDistance(from: cordinate) ?? 0.0 / 1000).rounded()
                  index += 1
              }
            providerServicesData =   providerServicesData.sorted { (one, two) -> Bool in
                  return one.distance ?? 0.0 < Double(farLocation ?? 0)
              }
        }
        providerServicesTableView.reloadData()
        
        // guard let catId = categoryId else {return}
        
        self.categoryId = categoryId
        //guard let maxprice = maxRange else {return}
        self.maxPrice = maxRange
        //guard let minPrice = minRange else {return}
        self.minPrice = minRange
        self.locationRange = farLocation
        //  blackView.isHidden = true
        
//        searchAndFilter(keyword: nil, districtId: nil, time: nil, page: providerCurrentPage, date: nil, minPrice: minRange, maxPrice: maxRange, locationRange: farLocation, ratingFrom: ratingFrom, ratingTo: ratingTo, categoryId: categoryId, sortingId: nil)
    }
    
    func getDistance(from branch: CLLocation) -> CLLocationDistance? {
        let distance = currentLocation.distance(from: branch)
        return distance
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       // currentOffsetX = Int(scrollView.contentOffset.x)
        
    }
    
   
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        let lastSectionIndex = tableView.numberOfSections - 1
//        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
//        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
//            // print("this is the last cell")
//            let spinner = UIActivityIndicatorView()
//            spinner.color = UIColor.blueColor()
//            spinner.activityIndicatorView.hidesWhenStopped = true
//            spinner.startAnimating()
//            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
//            self.providerServicesTableView.tableFooterView = spinner
//            self.providerServicesTableView.tableFooterView?.isHidden = false
//            if searchByCategory == true {
//                loadMoreProviderServices()
//            } else {
//                seaarchMore()
//                print(indexPath.row)
//            }
//            if indexPath.row == totalNumberOfItems-1 {
//                spinner.stopAnimating()
//                //spinner.isHidden = true
//                self.providerServicesTableView.tableFooterView?.isHidden = true
//                return
//            }
//
//
//        }
    }
    
    
    
}

extension ProviderServicesVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        currentLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
    }

}

extension UITableView {
    func setNoData () {
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        noDataLabel.text          = "No data available"
        noDataLabel.textColor     = #colorLiteral(red: 0.262745098, green: 0.5019607843, blue: 0.7607843137, alpha: 1)
        noDataLabel.textAlignment = .center
        self.backgroundView  = noDataLabel
        self.separatorStyle  = .none

    }
    func restore() {
        self.backgroundView = nil
    }
}
