//
//  ProviderDetailsVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/5/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import Cosmos


protocol BusinessProfileResizing {
    func resizeContainerViewHeight(with height: CGFloat)
}

class ProviderDetailsVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var menuChooseCollectionView: UICollectionView!
    @IBOutlet weak var temporeryMenuChoose: UICollectionView!
    @IBOutlet weak var embeddContainerView: UIView!
    @IBOutlet weak var embeddContainerViewConstraint: NSLayoutConstraint!
    var menuTitles = ["Services","Details","Report"]
    var selectedIndex = 0
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    var businessProfileDetailsVC : BusinessProfileDetailsVC?
   // @IBOutlet weak var tabBarTopConstraint: NSLayoutConstraint!

    @IBOutlet weak var sliderContainerImageView: UIImageView!
    @IBOutlet weak var imagesCountLabel: UILabel!
    @IBOutlet weak var providerNumberOfReviewsLabel: UILabel!
    @IBOutlet weak var subCategoryProviderTitle: UILabel!
    @IBOutlet weak var providerNameTitle: UILabel!
    @IBOutlet weak var imageViewProvdierProfile: UIImageView!
    @IBOutlet weak var providerRatingValue: CosmosView!
    var profileDetailsData: ProfileDetailsResponseModel?
    
    
    
    
    var providerId: Int?
    var urlsOfSlider: [String]?
    
    // MARK: Properties
    var businessProfileDetailsController: BusinessProfileDetailsVC?
   // var workingHoursController: BPWorkingHoursVC?
    //var reviewsController: BPReviewsVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        temporeryMenuChoose.layer.zPosition = 100
      //  temporeryMenuChoose.isHidden = true
        scrollView.delegate = self
        
        //tabBarTopConstraint.constant = 320
     //   self.businessProfileDetailsVC?.profileDetailsScrollView.delegate = self
       // menuChooseCollectionView.delegate = self
        //menuChooseCollectionView.dataSource = self
        menuChooseCollectionView.selectItem(at: selectedIndexPath , animated: false, scrollPosition: .centeredVertically)
        temporeryMenuChoose.selectItem(at: selectedIndexPath , animated: false, scrollPosition: .centeredVertically)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipedHappened(sender:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipedHappened(sender:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
      //  let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp(sender:)))
      //  upSwipe.direction = .up
      //  self.view.addGestureRecognizer(upSwipe)
        // self.topView.slideInFromUp()
    //    let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown(sender:)))
      //  downSwipe.direction = .down
      //  self.view.addGestureRecognizer(downSwipe)
         getProviderDetails()
        embedBPDetailsVC()
        
        self.businessProfileDetailsVC?.resourcesTableView.estimatedRowHeight = 150
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BusinessProfileDetailsVC, segue.identifier == "BusinessProfileDetailsSegue" {
                // Now you have a pointer to the child view controller.
                // You can save the reference to it, or pass data to it.
            
        }
        
    }

    
    func getProviderDetails() {
        
        let services = BusinessprofileServices()
        self.showLoading()
        services.getProfileDetails(for: 1, completion: { (error, data) in
            self.hideLoading()
//            if let error = error{
//                self.alertUser(title: "", message: error)
//                return
//            }
//            guard let data = data else{return}
//            self.profileDetailsData = data.providers
//            self.displayData(profileDetailsData: self.profileDetailsData)
//            self.businessProfileDetailsVC?.subProfileDetailsData = self.profileDetailsData
//            self.businessProfileDetailsVC?.resourcesWorkingDay = self.profileDetailsData?.workingDays.data
//            DispatchQueue.main.async {
//                self.businessProfileDetailsVC?.resourcesCollectionView.reloadData()
//                self.businessProfileDetailsVC?.resourcesTableView.reloadData()
//            }
//            print(self.profileDetailsData!)

        })
        
    }
    var index = 0
    func displayData(profileDetailsData: ProfileDetailsResponseModel?){
        guard let providerTitle = profileDetailsData?.businessName else {return}
        providerNameTitle.text = providerTitle
        subCategoryProviderTitle.text = profileDetailsData?.subCategoryName
        providerNumberOfReviewsLabel.text = "\(profileDetailsData?.raters ?? 0)"
        providerRatingValue.rating = Double((profileDetailsData?.rate)!)
        let url = URL(string: (profileDetailsData?.image)!)
        imageViewProvdierProfile?.sd_setImage(with: url, completed: nil)
        imagesCountLabel.text = "\(profileDetailsData?.imagesCount ?? 0)"
        // guard let imagesCount
        let sliderUrlImage = URL(string: (profileDetailsData?.images!.data![index].image)!)
        sliderContainerImageView!.sd_setImage(with: sliderUrlImage, completed: nil)
    }
    @IBAction func onTappedNextSliderButton(_ sender: UIButton) {
        index = index + 1
        if index <= (profileDetailsData?.imagesCount)!-1 {
            let sliderUrlImage = URL(string: (profileDetailsData?.images!.data![index].image)!)
            sliderContainerImageView!.sd_setImage(with: sliderUrlImage, completed: nil)
        } else {
            index = (profileDetailsData?.imagesCount)! - 1
            print(index)
            return
        }
    }
    
    @IBAction func onTappedPreviousSliderButton(_ sender: UIButton) {
        index = index - 1
        if index >= 0 {
            let sliderUrlImage = URL(string: (profileDetailsData?.images!.data![index].image)!)
            sliderContainerImageView!.sd_setImage(with: sliderUrlImage, completed: nil)
        } else {
            index = 0
            return
            
        }
        
    }
    
    func saveContrainerViewRefference(vc:BusinessProfileDetailsVC){
        self.businessProfileDetailsVC = vc
    }
    
    @objc func SwipedHappened(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            if selectedIndex < menuTitles.count - 1 {
                selectedIndex += 1
            }
        } else {
            if selectedIndex > 0  {
                selectedIndex -= 1
            }
        }
        selectedIndexPath = IndexPath(item: selectedIndex, section: 0)
        menuChooseCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredVertically)
        temporeryMenuChoose.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredVertically)
        refreshContent()
    }
    
    func refreshContent() {
        //table reload
    }
    
    private func embedBPDetailsVC(){
        // check if businessInfoController is already exist.
        guard businessProfileDetailsController == nil else {return}
        
        // make sure to remove any subViews in the container.
        removeContainerSubViews()
        
        // embed businessInfoController in the container.
        businessProfileDetailsController = UIStoryboard.getBPBusinessInfoVC()
        businessProfileDetailsController!.resizeBPdelegate = self
        //businessProfileDetailsController!.branches = branches
        businessProfileDetailsController!.view.translatesAutoresizingMaskIntoConstraints = false
        businessProfileDetailsController!.willMove(toParent: self)
        self.embeddContainerView.addSubview(businessProfileDetailsController!.view)
        businessProfileDetailsController!.view.leadingAnchor.constraint(equalTo: self.embeddContainerView.leadingAnchor).isActive = true
        businessProfileDetailsController!.view.trailingAnchor.constraint(equalTo: self.embeddContainerView.trailingAnchor).isActive = true
        businessProfileDetailsController!.view.topAnchor.constraint(equalTo: self.embeddContainerView.topAnchor).isActive = true
        businessProfileDetailsController!.view.bottomAnchor.constraint(equalTo: self.embeddContainerView.bottomAnchor).isActive = true
        self.addChild(businessProfileDetailsController!)
        businessProfileDetailsController!.didMove(toParent: self)
        self.businessProfileDetailsVC = businessProfileDetailsController
        businessProfileDetailsVC!.subProfileDetailsData = self.profileDetailsData
    }
    

    private func removeContainerSubViews(){
        for view in embeddContainerView.subviews{
            view.removeFromSuperview()
        }
        
        businessProfileDetailsController = nil
       // workingHoursController = nil
        //reviewsController = nil
    }
}
extension ProviderDetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width /
            CGFloat(menuTitles.count), height: collectionView.bounds.height)
    }
}

private extension UIStoryboard{
    
    static func getBPBusinessInfoVC() -> BusinessProfileDetailsVC {
        return Initializer.createViewController(storyBoard: .BusinessProfileSB, andId: "BusinessProfileDetailsVC") as! BusinessProfileDetailsVC
    }
    
//    static func getBPWorkingHoursVC() -> BPWorkingHoursVC {
//        return Initializer.createViewController(storyBoard: .BusinessProfileSB, andId: "BPWorkingHoursVC") as! BPWorkingHoursVC
//    }
//
//    static func getBPBusinessInfoVC() -> BPBusinessInfoVC {
//        return Initializer.createViewController(storyBoard: .BusinessProfileSB, andId: "BPBusinessInfoVC") as! BPBusinessInfoVC
//    }
}


extension ProviderDetailsVC: UICollectionViewDelegate {
    
}
extension ProviderDetailsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.setupCell(text: menuTitles[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        if selectedIndex == 0 {
            embedBPDetailsVC()
        }
        if selectedIndex == 1 {
            embedBPDetailsVC()
        }
        if selectedIndex == 2 {
            embedBPDetailsVC()
        }
    }
}
extension ProviderDetailsVC: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scroll: \(scrollView.contentOffset.y)")
        let container = topView.frame.height
        let yPosition = scrollView.contentOffset.y
        
        if yPosition >= container {
            if temporeryMenuChoose.isHidden {
                temporeryMenuChoose.isHidden = false
                menuChooseCollectionView.isHidden = true
            }
        }else{
            if !temporeryMenuChoose.isHidden {
                temporeryMenuChoose.isHidden = true
                menuChooseCollectionView.isHidden = false
            }
        }
    }

//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        if scrollView == self.businessProfileDetailsVC?.profileDetailsScrollView {
//            tabBarTopConstraint.constant = 20
//
//        }
//    }
//    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
//        tabBarTopConstraint.constant = 320
//    }
}

extension ProviderDetailsVC: BusinessProfileResizing{
    func resizeContainerViewHeight(with height: CGFloat) {
        self.embeddContainerViewConstraint.constant = height
        self.embeddContainerView.layoutIfNeeded()
        print(self.embeddContainerViewConstraint.constant)
    }
}
