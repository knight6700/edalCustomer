//
//  BusinessProfileDetailsVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/4/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class BusinessProfileDetailsVC: UIViewController {
    
    //MARK:- Properties
    //Outlets
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var businessStreetCityLabel: UILabel!
    @IBOutlet weak var businessLocationLabel: UILabel!
    @IBOutlet weak var resourcesCollectionView: UICollectionView!
    @IBOutlet weak var profileDetailsScrollView: UIScrollView!
    @IBOutlet weak var resourcesTableView: UITableView!
    
    @IBOutlet weak var containerView: UIView!
    //variables
    var subProfileDetailsData: ProfileDetailsResponseModel?
    var resourcesWorkingDay: [WorkingDaysDatum]?
    var resizeBPdelegate: BusinessProfileResizing?
    override func viewDidLoad() {
        super.viewDidLoad()
        resourcesTableView.delegate = self
        resourcesTableView.dataSource = self
        resourcesCollectionView.delegate = self
        resourcesCollectionView.dataSource = self
        resourcesTableView.estimatedRowHeight = 150
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       /// profileDetailsScrollView.isScrollEnabled = false
        recizeBPContainer()
        let providerDetailsVCParent = self.parent as! ProviderDetailsVC
        providerDetailsVCParent.saveContrainerViewRefference(vc: self)
        subProfileDetailsData = providerDetailsVCParent.profileDetailsData
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //recizeBPContainer()
        
    }
    
    private func recizeBPContainer(){
        let containerHeight = containerView.frame.height
        print(containerHeight)
        print()
        resizeBPdelegate?.resizeContainerViewHeight(with: containerHeight)
        // the 48 is the height of the branches label and the constraints between
        // it and branchesTableView
    }
    
    
    func convertDaysToStrings(withNoOfDay: Int?)-> String {
        if let day = withNoOfDay {
            switch day {
            case 0:
                return "Saturday"
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednesday"
            case 5:
                return "Thrusday"
            case 6:
                return "Friday"
            default:
                return "Not Found"
            }
        }
        return "Not Found"
    }
}
extension BusinessProfileDetailsVC: UICollectionViewDelegate {
    
}

extension BusinessProfileDetailsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = subProfileDetailsData?.resources!.data?.count else {return 0}
        return count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resourcesCollectionView.dequeueReusableCell(withReuseIdentifier: "resourcesCell", for: indexPath) as! ResourcesCollectionViewCell
        cell.resourcesImageView.addImage(withImage: subProfileDetailsData?.resources!.data![indexPath.row].image , andPlaceHolder: "")
        cell.resourcesNameLabel.text = subProfileDetailsData?.resources!.data![indexPath.row].name
        cell.resourcesTitleLabel.text = subProfileDetailsData?.resources!.data![indexPath.row].position
        return cell
    }
    
    
}

extension BusinessProfileDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = resourcesWorkingDay?.count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resourcesTableView.dequeueReusableCell(withIdentifier: "ResourcesTableViewCell", for: indexPath) as! ResourcesTableViewCell
        let day = resourcesWorkingDay![indexPath.row].day
        cell.resourcesDayLabel.text = convertDaysToStrings(withNoOfDay: day)
        cell.resourcesStartTimeLabel.text = resourcesWorkingDay?[indexPath.row].from
        cell.resourcesEndTimeLabel.text = resourcesWorkingDay?[indexPath.row].to
        return cell
    }
    
    
}
extension BusinessProfileDetailsVC: UITableViewDelegate {
    
}
