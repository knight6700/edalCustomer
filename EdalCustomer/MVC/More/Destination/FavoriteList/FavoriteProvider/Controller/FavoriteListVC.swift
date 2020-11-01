//
//  FavoriteListVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/15/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class FavoriteListVC: UIViewController, RecommendedCellDelegate {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    var numberOfPage = 1
    var totalPages: Int {
        return self.providersData?.defaultResponse?.providers?.meta?.pagination?.totalPages ?? 0
    }
    var isLoading = true

    var providersData: FavoriteListModel?
    var favoriteProvider: FavoriteProvider?
    var firstTime = true
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        Configuration()
        getFavoriteProviders()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: configureCollectionView
    func Configuration() {
        favoriteTableView.register(UINib.init(nibName: "RecommendedCell", bundle: nil), forCellReuseIdentifier: "RecommendedCell")
        favoriteTableView.register(UINib.init(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        favoriteTableView.estimatedRowHeight = 200
    }
    
    var pageNum = 0
    func getFavoriteProviders() {
        if numberOfPage == 1 {
            self.showLoading()
        }
        self.isLoading = true
        let services = FavoriteProviderServices()
        services.getFavoriteProvider(page: numberOfPage) { [weak self] (error, data) in
            self?.isLoading = false
            self?.hideLoading()
            if let error = error {
                if self?.firstTime ?? true {
                    self?.alertUser(title: "Error", message: error)
                    self?.firstTime = false
                }
                self?.getFavoriteProviders()
                return
            }
                if self?.providersData == nil {
                    self?.providersData = data
                }else {
                    guard let array = data?.defaultResponse?.providers?.data else {return}
                    self?.providersData?.defaultResponse?.providers?.data?.append(contentsOf: array)
                }
                DispatchQueue.main.async {
                    self?.favoriteTableView.reloadData()
                }
                self?.numberOfPage += 1
                self?.isLoading = false
            }
    }
    
    func addFooterReffresher() {
        guard !isLoading else { return }
        if self.numberOfPage <= totalPages {
            getFavoriteProviders()
        }
    }

    
    func addFavorite(){
        let services = FavoriteProviderServices()
        
        services.updateFavoriteProvider(withProviderId: 1, favorite: 1) { (error, data) in
            
            if let error = error {
                self.alertUser(title: "", message: error)
                return
            }
            
            guard data != nil else {return}
            
            
        }
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
}

extension FavoriteListVC: UITableViewDelegate {
    
}

extension FavoriteListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = providersData?.defaultResponse?.providers?.data?.count ?? 0
        if count  > 0 {
            tableView.backgroundView = nil
            guard  numberOfPage <= totalPages else {
                self.favoriteTableView.restore()
                return count
            }
            favoriteTableView.restore()
            return count + 1
        }else {
            self.favoriteTableView.setNoData()
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendedCell", for: indexPath) as? RecommendedCell else {
            return UITableViewCell()
        }
        if indexPath.row == providersData?.defaultResponse?.providers?.data?.count ?? 0 - 1 ,
            numberOfPage <= totalPages{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingTableViewCell
            cell.loadingIndicator.startAnimating()
            return cell
        }else {
            cell.recommendedDelegate = self
            guard let data = providersData?.defaultResponse?.providers?.data?[indexPath.row] else {return cell}
            cell.businessNameLabel.text = data.businessName ?? ""
            let businessImage = URL(string: data.bgImage ?? "")
            cell.businessImageView.sd_setImage(with: businessImage)
            cell.categoriesNameLabel.text = data.categoryName?.rawValue ?? ""
            if data.images?.data?.count == 0 {
                cell.imagesCountLabel.text = "No Photos"
            }else {
                cell.imagesCountLabel.text = "\(data.images?.data?.count ?? 0) Photos"
            }
            cell.categoriesRateView.rating = Double(data.rate ?? 0)
            let bgImage = URL(string: data.bgImage ?? "")
            cell.bgImageView.sd_setImage(with: bgImage ?? URL(string: ""))
            cell.maxValuePriceLabel.text = formatPoints(num: data.maxValue ?? 0)
            cell.minValuePriceLabel.text = formatPoints(num: data.minValue ?? 0)
            if data.favorite == false {
                cell.favButton.setImage(#imageLiteral(resourceName: "faviconUn"), for: .normal)
            } else {
                cell.favButton.setImage(#imageLiteral(resourceName: "faviconact"), for: .normal)
            }
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !isLoading else { return }
            if numberOfPage <= totalPages {
                let array = self.providersData?.defaultResponse?.providers?.data?.count ?? 0 - 1
                if indexPath.row  == array {
                    addFooterReffresher()
                }
            }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = providersData?.defaultResponse?.providers?.data?[indexPath.row] else {return}
        let images = item.images?.data?.map({$0.image ?? ""})
        let id = "ServiceItemDetailsViewController"
        let vc = Initializer.createViewController(storyBoard: .HomeSB, andId: id) as! ServiceItemDetailsViewController
        vc.subServiceId = item.id!
        vc.serviceItemDetailsModel = ServiceItemDetailsModel(imageUrl: item.image ?? "", name: item.businessName ?? "", images: images ?? [String](), type: item.categoryName?.rawValue ?? "" ,rate: Double(item.rate ?? 0) , totalReview: item.raters ?? 0,isFavourite: item.favorite ?? false)

        self.navigationController?.pushViewController(vc, animated: true)

    }
    
}
extension FavoriteListVC {
    
    
    func didPressFavButton(cell: RecommendedCell) {
        if let indexPath = favoriteTableView.indexPath(for: cell) {
            // do Something
            guard let data = providersData?.defaultResponse?.providers?.data?[indexPath.row] else {return}
            let favoriteValue = data.favorite
            if favoriteValue == false {
                // recommendedCategoriesData[indexPath]
                updateFavCategories(proId: data.id ?? 0, fav: 1)
                cell.favButton.setImage(#imageLiteral(resourceName: "faviconact"), for: .normal)
            } else {
                updateFavCategories(proId: data.id ?? 0, fav: 0)
                cell.favButton.setImage(#imageLiteral(resourceName: "faviconUn"), for: .normal)
            }
        }
    }
    
    
}
