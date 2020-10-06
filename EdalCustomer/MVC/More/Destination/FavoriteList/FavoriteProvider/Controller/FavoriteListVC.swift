//
//  FavoriteListVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/15/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class FavoriteListVC: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var providersData: [HomeProvidersDatum]?
    var favoriteProvider: FavoriteProvider?
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        Configuration()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: configureCollectionView
    func Configuration() {
        favoriteTableView.register(UINib.init(nibName: "RecommendedCell", bundle: nil), forCellReuseIdentifier: "RecommendedCell")
        favoriteTableView.estimatedRowHeight = 190
    }

    var pageNum = 0
    func getFavoriteProviders() {
        let services = FavoriteProviderServices()
        services.getFavoriteProvider(page: 1) { (error, data) in
            if let error = error {
                self.alertUser(title: "", message: error)
                return
            }
            
            guard let data = data else {return}
            // medhat commented
           // self.providersData = data.default_response?.providers.data
           // if self.pageNum <  data.default_response!.providers.meta.pagination.total_pages {
                services.getFavoriteProvider(page: self.pageNum) { (error, data) in
                    if let error = error {
                        self.alertUser(title: "", message: error)
                        return
                    }
                    
                    guard let data = data else {return}
                   // guard self.providersData != nil else {return}
                   // self.providersData = self.providersData! + (data.default_response?.providers.data)!
                    self.pageNum = self.pageNum + 1
                }
                
          //  }
           
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

}

extension FavoriteListVC: UITableViewDelegate {
    
}

extension FavoriteListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
