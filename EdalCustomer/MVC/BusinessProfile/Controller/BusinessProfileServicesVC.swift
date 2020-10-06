//
//  BusinessProfileServicesVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/17/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class BusinessProfileServicesVC: UIViewController {

    @IBOutlet weak var servicesTableView: UITableView!
    

    var profileDetailsData: ProfileDetailsResponseModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        servicesTableView.delegate = self
        servicesTableView.dataSource = self
        servicesTableView.register(SerivcesProductCell.self, forCellReuseIdentifier: "SerivcesProductCell")
        // Do any additional setup after loading the view.
    }
    
    func getProviderDetails() {
        
        let services = BusinessprofileServices()
        self.showLoading()
        services.getProviderSubServices(for: 1, completion: { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let data = data else{return}
//            self.profileDetailsData = data.providers
            self.servicesTableView.reloadData()
            //self.displayData(profileDetailsData: self.profileDetailsData)
            
            print(self.profileDetailsData!)
            
        })
        
    }
}

extension BusinessProfileServicesVC: UITableViewDelegate {
    
}

extension BusinessProfileServicesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
