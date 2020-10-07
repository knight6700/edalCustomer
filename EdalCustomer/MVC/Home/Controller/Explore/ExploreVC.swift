//
//  ExploreVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/23/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class ExploreVC: UIViewController {

    @IBOutlet weak var mainExploreCollectionView: UICollectionView!
    @IBOutlet weak var recommendedTableView: IntrinsicTableView!
    @IBOutlet weak var recentlyBookCollectionView: UICollectionView!
    var mainExploreCategoriesData = [ProviderUserModel]()
    var recentlyBookCategoriesData = [serviceData]()
    var recommendedCategoriesData = [ProviderUserModel]()
    fileprivate let cellIdentifier = "ExploreCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hideLoading()
        mainExploreCollectionView.delegate = self
        mainExploreCollectionView.dataSource = self
        recommendedTableView.delegate = self
        recommendedTableView.dataSource = self
        recentlyBookCollectionView.delegate = self
        recentlyBookCollectionView.dataSource = self
       
        getMainExploreCategories()
        Configuration()
 
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationBar()
      
    }
    
    
    //MARK:- Handling Navigation Bar
    func handleNavigationBar(){
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.title = " "
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    //MARK: configureCollectionView
    func Configuration() {
        mainExploreCollectionView.backgroundColor = .clear
        mainExploreCollectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        recentlyBookCollectionView.register(UINib.init(nibName: "RecentlyBookCell", bundle: nil), forCellWithReuseIdentifier: "RecentlyBookCell")
        recommendedTableView.register(UINib.init(nibName: "RecommendedCell", bundle: nil), forCellReuseIdentifier: "RecommendedCell")
        recommendedTableView.estimatedRowHeight = 190
    }
    
    func getAllCategories(for page: Int) {
       // mainExploreCollectionView.fa
    }
    
    func getMainExploreCategories() {
        let services = HomeServices()
        self.showLoading()
        services.getHome(completion: { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let _ = data else{return}
            
            self.mainExploreCategoriesData = (data?.homeProviders?.data)!
            self.recentlyBookCategoriesData = (data?.recentServices?.data)!
            self.recommendedCategoriesData = (data?.recommendedProviders?.data)!
            print("main", self.mainExploreCategoriesData)
            self.mainExploreCollectionView.reloadData()
            print("recent", self.recentlyBookCategoriesData)
            self.recentlyBookCollectionView.reloadData()
            print("recommended", self.recommendedCategoriesData)
            self.recommendedTableView.reloadData()
        })
    }
    
    func updateFavCategories(proId: Int, fav: Int) {
        let services = FavoriteProviderServices()
        self.showLoading()
        services.updateFavoriteProvider(withProviderId: proId, favorite: fav, completion: { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "Error" , message: error)
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
    
}
//MARK:- Collection View Delegate FlowLayout
extension ExploreVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.mainExploreCollectionView {
        //getting screen width to set height and width of collection view cell item
       // let screenWidth = UIScreen.main.bounds.width
        let width = 315.0
        let height = 139.0
     
       return CGSize.init(width: width, height: height)
        }else {
            let width = 152.0
            let height = 189.0
            return CGSize.init(width: width, height: height)
        }
    }
}

//MARK:- Collection View Data Source
extension ExploreVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainExploreCollectionView {
            return mainExploreCategoriesData.count
        } else {
            return recentlyBookCategoriesData.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.mainExploreCollectionView {
        guard let cell = mainExploreCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ExploreCollectionViewCell else {
            return UICollectionViewCell()
        }
            cell.exploreCellDelegate = self
            cell.businessNameLabel.text = mainExploreCategoriesData[indexPath.item].businessName
            let businessImage = URL(string: mainExploreCategoriesData[indexPath.item].image!)
            print("image_url:\(String(describing: businessImage))")
            cell.businessImageView.sd_setImage(with: businessImage ?? URL(string: ""))
            cell.categoriesNameLabel.text = mainExploreCategoriesData[indexPath.item].categoryName
            if mainExploreCategoriesData[indexPath.item].imagesCount == 0 {
                cell.imagesCountLabel.text = "No Photos"
            } else {
                cell.imagesCountLabel.text = "\(mainExploreCategoriesData[indexPath.item].imagesCount ?? 0) Photos"
            }
            
            cell.categoriesRateView.rating = Double(mainExploreCategoriesData[indexPath.item].rate!)
            let bgImage = URL(string: mainExploreCategoriesData[indexPath.item].bg_image!)
            print("image_url:\(String(describing: bgImage))")
            cell.bgImageView.sd_setImage(with: bgImage ?? URL(string: ""))
            if mainExploreCategoriesData[indexPath.row].maxValue! >= 1000{
                cell.maxValuePriceLabel.text = formatPoints(num: mainExploreCategoriesData[indexPath.item].maxValue!)
            }
           
            cell.minValuePriceLabel.text = formatPoints(num: mainExploreCategoriesData[indexPath.item].minValue! )
            
            if mainExploreCategoriesData[indexPath.item].favorite == false {
                cell.FavButton.setImage(#imageLiteral(resourceName: "faviconUn"), for: .normal)
            } else {
                cell.FavButton.setImage(#imageLiteral(resourceName: "faviconact"), for: .normal)
            }
            
        return cell
        } else {
            
            guard let cell = recentlyBookCollectionView.dequeueReusableCell(withReuseIdentifier: "RecentlyBookCell", for: indexPath) as? RecentlyBookCell else {
                return UICollectionViewCell()
            }
            cell.businessNameLabel.text = recentlyBookCategoriesData[indexPath.item].name
            let bgImage = URL(string: recentlyBookCategoriesData[indexPath.item].icon!)
            print("image_url:\(String(describing: bgImage))")
            cell.bgImageView.sd_setImage(with: bgImage ?? URL(string: ""))
            cell.maxValuePriceLabel.text = formatPoints(num: recentlyBookCategoriesData[indexPath.item].maxValue)
            cell.minValuePriceLabel.text = formatPoints(num: (recentlyBookCategoriesData[indexPath.item].minValue ?? 0 ) as! Int)
           
            return cell
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == mainExploreCollectionView {
             return 1
        } else {
            return 1
        }
       
    }

}

//MARK:- Collection View Delegate
extension ExploreVC: UICollectionViewDelegate{
    //Loading More items
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row ==  movieListResults.count - 1{
//            loadMore()
//        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //MARK:- Navigation to Movie Details
        if collectionView == self.mainExploreCollectionView{
            let item = mainExploreCategoriesData[indexPath.row]
            let id = "ServiceItemDetailsViewController"
            let vc = Initializer.createViewController(storyBoard: .HomeSB, andId: id) as! ServiceItemDetailsViewController
            vc.subServiceId = item.id!
            vc.serviceItemDetailsModel = ServiceItemDetailsModel(imageUrl: item.image ?? "", name: item.businessName ?? "", images: [item.image ?? ""], type: item.categoryName ?? "",rate: item.rate ?? 0.0, totalReview: item.raters ?? 0,isFavourite: item.favorite ?? false)
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let item = recentlyBookCategoriesData[indexPath.row]

            // navigator.navigate(to: .serviceItemdetail())
            let id = "ServiceItemDetailsViewController"
            let vc = Initializer.createViewController(storyBoard: .HomeSB, andId: id) as! ServiceItemDetailsViewController
            vc.serviceItemDetailsModel = ServiceItemDetailsModel(imageUrl: item.icon ?? "", name: item.name ?? "", images: [item.icon ?? ""], type: "SPA" ,rate: 4.0, totalReview: 50,isFavourite: true)
            vc.subServiceId = item.id!
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
      

    }
    
    private func didPrssedCollectionView(index: Int) {
               // do Something
            
    }
}

//MARK:- Table View Data Source
extension ExploreVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return recommendedCategoriesData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didPressItemButton(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendedCell", for: indexPath) as? RecommendedCell else {
           return UITableViewCell()
        }
        cell.recommendedDelegate = self
        cell.businessNameLabel.text = recommendedCategoriesData[indexPath.item].businessName
        let businessImage = URL(string: recommendedCategoriesData[indexPath.item].image!)
        print("image_url:\(String(describing: businessImage))")
        cell.businessImageView.sd_setImage(with: businessImage)
        cell.categoriesNameLabel.text = recommendedCategoriesData[indexPath.item].categoryName
        if recommendedCategoriesData[indexPath.item].imagesCount == 0 {
            cell.imagesCountLabel.text = "No Photos"
        }else {
            cell.imagesCountLabel.text = "\(recommendedCategoriesData[indexPath.item].imagesCount ?? 0) Photos"
        }
        
        
        
        cell.categoriesRateView.rating = Double(recommendedCategoriesData[indexPath.item].rate ?? 0)
        let bgImage = URL(string: recommendedCategoriesData[indexPath.item].bg_image!)
        print("image_url:\(String(describing: bgImage))")
        cell.bgImageView.sd_setImage(with: bgImage ?? URL(string: ""))
        cell.maxValuePriceLabel.text = formatPoints(num: recommendedCategoriesData[indexPath.item].maxValue!)
        cell.minValuePriceLabel.text = formatPoints(num: recommendedCategoriesData[indexPath.item].minValue!)
        if recommendedCategoriesData[indexPath.item].favorite == false {
            cell.favButton.setImage(#imageLiteral(resourceName: "faviconUn"), for: .normal)
        } else {
            cell.favButton.setImage(#imageLiteral(resourceName: "faviconact"), for: .normal)
        }
        
        
        return cell
    }
    
    
}
//MARK:- Table View Data Source
extension ExploreVC: UITableViewDelegate {
    
}


extension ExploreVC : RecommendedCellDelegate {
    
   
    func didPressFavButton(cell: RecommendedCell) {
        if let indexPath = recommendedTableView.indexPath(for: cell) {
            // do Something
            let favoriteValue = recommendedCategoriesData[indexPath.row].favorite
            if favoriteValue == false {
               // recommendedCategoriesData[indexPath]
                updateFavCategories(proId: recommendedCategoriesData[indexPath.row].id!, fav: 1)
                cell.favButton.setImage(#imageLiteral(resourceName: "faviconact"), for: .normal)
            } else {
                updateFavCategories(proId: recommendedCategoriesData[indexPath.row].id!, fav: 0)
                cell.favButton.setImage(#imageLiteral(resourceName: "faviconUn"), for: .normal)
            }
        }
    }
    
    
}

extension ExploreVC : ExploreCellDelegate {
    
    func didPressItemButton(index: Int) {
           // do Something
        let item = recommendedCategoriesData[index]
        let id = "ServiceItemDetailsViewController"
        let vc = Initializer.createViewController(storyBoard: .HomeSB, andId: id) as! ServiceItemDetailsViewController
        vc.subServiceId = item.id!
        vc.serviceItemDetailsModel = ServiceItemDetailsModel(imageUrl: item.image ?? "", name: item.business_name ?? "", images: [item.bg_image ?? ""], type: item.categoryName ?? "" ,rate: item.rate ?? 0.0, totalReview: item.raters ?? 0,isFavourite: item.favorite ?? false)

        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    func didPressFavButton(cell: ExploreCollectionViewCell) {
        if let indexPath = mainExploreCollectionView.indexPath(for: cell) {
            // do Something
            let favoriteValue = mainExploreCategoriesData[indexPath.item].favorite
            if favoriteValue == false {
                // recommendedCategoriesData[indexPath]
                updateFavCategories(proId: mainExploreCategoriesData[indexPath.item].id!, fav: 1)
                cell.FavButton.setImage(#imageLiteral(resourceName: "faviconact"), for: .normal)
            } else {
                updateFavCategories(proId: mainExploreCategoriesData[indexPath.item].id!, fav: 0)
                cell.FavButton.setImage(#imageLiteral(resourceName: "faviconUn"), for: .normal)
            }
        }
    }
    
    
}


