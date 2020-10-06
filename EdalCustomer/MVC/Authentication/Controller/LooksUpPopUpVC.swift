//
//  LooksUpPopUpVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/1/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit


enum LookUpPopUpType {
    case selectCity
    case selectDistrict
    case selectAge
    case selectCategory
}

protocol LookUpPopUpDataSource {
    func citySelectedWith(city: LookupAllDataModel)
    func districtSelectedWith(district: LookupAllDataModel)
    func ageSelectedwith(age: LookupAllDataModel)
}
protocol SearchLookUpDataSource {
    func categorySelectedWith(category: CategoriesData)
}

class LooksUpPopUpVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: LookUpCustomTableView!
    @IBOutlet weak var lookUpForLabel: UILabel!
    
    // MARK: Properties
    var lookUpPopUpType = LookUpPopUpType.selectCity
    var LookUpPopUpDelegate: LookUpPopUpDataSource?
    var lookUpAll: LookupAllModel?
    var lookUpDistricts: LookupDistrictsModel?
    
    //search lookupPopup
    var searchLookupDelegate: SearchLookUpDataSource?
    var searchCategoriesLookup: Categories?

    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setupUI()
    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    func configuration(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
        tableView.roundView(withCorner: 10)
    }

    // MARK: Actions
    @IBAction func onTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


// MARK: UITableViewDelegate, UITableViewDataSource
extension LooksUpPopUpVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch lookUpPopUpType {
        case .selectCity:
            guard let count = lookUpAll?.cities!.data?.count else {return 0}
            return count
        case .selectDistrict:
            guard let count = lookUpDistricts?.districts!.data?.count else {return 0}
            return count
        case .selectAge:
            guard let count = lookUpAll?.ages?.data?.count else {return 0}
            print(count)
            return count
            
        case .selectCategory:
            guard let count = searchCategoriesLookup?.data?.count else {return 0}
            print(count)
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // id -----> for all
        // title --> for business_sizes, years_of_experience, districts
        // name ---> for categories, cities
        // icon ---> for categories
        
        switch lookUpPopUpType {
        case .selectCity:
            lookUpForLabel.text = "Select City"
            guard let data = lookUpAll?.cities!.data else {return UITableViewCell()}
            let city = data[indexPath.row]
            cell.textLabel?.text = city.name
            
        case .selectDistrict:
            lookUpForLabel.text = "Select District"
            guard let data = lookUpDistricts?.districts!.data else {return UITableViewCell()}
            let district = data[indexPath.row]
            cell.textLabel?.text = district.title
            
        case .selectAge:
            lookUpForLabel.text = "Select Age"
            guard let data = lookUpAll?.ages!.data else {return UITableViewCell()}
            let age = data[indexPath.row]
            cell.textLabel?.text = age.title
            
        case .selectCategory:
            lookUpForLabel.text = "Select Category"
            guard let categories = searchCategoriesLookup?.data else {return UITableViewCell()}
            let category = categories[indexPath.row]
            cell.textLabel?.text = category.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch  lookUpPopUpType{
        case .selectCity:
            guard let data = lookUpAll?.cities!.data else {return}
            let city = data[indexPath.row]
            LookUpPopUpDelegate?.citySelectedWith(city: city)
  
        case .selectDistrict:
            guard let data = lookUpDistricts?.districts!.data else {return}
            let district = data[indexPath.row]
            LookUpPopUpDelegate?.districtSelectedWith(district: district)
            
        case .selectAge:
            guard let selectedAge = lookUpAll?.ages!.data else {return}
           // Defaults.AgeId = indexPath.row + 1
            //print(Defaults.AgeId)
            let ages = selectedAge[indexPath.row]
            LookUpPopUpDelegate?.ageSelectedwith(age: ages)
            
        case .selectCategory:
            guard let categories = searchCategoriesLookup?.data else {return}
            let caterogy = categories[indexPath.row]
            searchLookupDelegate?.categorySelectedWith(category: caterogy)
             print(caterogy)
        }
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.removeFromSuperview()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
