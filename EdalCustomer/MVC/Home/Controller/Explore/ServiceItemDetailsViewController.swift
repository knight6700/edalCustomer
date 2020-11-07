//
//  ServiceItemDetailsViewController.swift
//  edal-IosCustomerApp
//
//  Created by Mahmoud Maamoun on 1/15/20.
//  Copyright © 2020 hesham ghalaab. All rights reserved.
//

import UIKit
import Cosmos

struct ServiceItemDetailsModel {
    var imageUrl: String
    var name: String
    var images: [String]
    var type: String
    var rate: Double
    var totalReview: Int
    var isFavourite: Bool
//    var details: String
//    var reviews: String
}
class ServiceItemDetailsViewController: UIViewController,UIScrollViewDelegate {
var scrollView = UIScrollView(frame: CGRect(x:0, y:100, width:320 , height: 523))
var frame: CGRect = CGRect(x:20, y:0, width:0, height:0)
    
    @IBOutlet weak var servBtn: UIButton!
    @IBOutlet weak var detailsBtn: UIButton!
    @IBOutlet weak var reviewsBtn: UIButton!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var topHeaderV: UIView!
    @IBOutlet weak var detalsV: UIView!
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var totalReviewsLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var favButton: UIButton!
    var isSearchable: Bool = false
    
    var serviceItemDetailsModel:ServiceItemDetailsModel?
    
    var subServiceId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeImage.setRounded()
        detalsV.scale()
        //tbView.scale()
        getSubServiceInfo ()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isSearchable {
         self.navigationController?.navigationBar.isHidden = true
         }

    }
    
    private func setupUI() {
        
        guard let service = serviceItemDetailsModel else {return}
        headerLabel.text = service.name
        typeLabel.text = service.type
        totalReviewsLabel.text = "\(service.totalReview) Reviews"
        storeImage.sd_setImage(with: URL(string: service.imageUrl), completed: nil)
        if service.isFavourite  {
            favButton.setImage(#imageLiteral(resourceName: "faviconact"), for: .normal)
        } else {
            favButton.setImage(#imageLiteral(resourceName: "unfavorite"), for: .normal)
        }
        
    }
    
    func initScrollView() {
        scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:self.view.frame.width , height: 200 ))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.clipsToBounds = true
        self.topHeaderV.addSubview(scrollView)
        for index in 0..<4 {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            let subView = Bundle.main.loadNibNamed("Intro", owner: self, options: nil)! [0] as! IntroUIScrollView
            subView.image.addImage(withImage: "", andPlaceHolder: "edallogo")
            subView.frame = frame
            subView.backgroundColor = UIColor.clear
            self.scrollView.addSubview(subView)
            //            scrollView.scale()
        }
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 4,height: self.scrollView.frame.size.height)
               
    }
    var indecatorIndex = 0
    @IBAction func leftArrowBtn(_ sender: Any) {
        if indecatorIndex >= 1 && indecatorIndex <= 4 {
                 indecatorIndex -= 1
             let x = CGFloat(indecatorIndex) * scrollView.frame.size.width
             
             scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
             }
    }
    @IBAction func rightBtn(_ sender: Any) {
        if indecatorIndex >= 0 && indecatorIndex <= 3 {
            indecatorIndex += 1
        let x = CGFloat(indecatorIndex) * scrollView.frame.size.width
        
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
        }
    }
    
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        self.showLoading()
        guard let service = serviceItemDetailsModel else {return}
        if service.isFavourite == false  {
            // recommendedCategoriesData[indexPath]
            bookngService.favItem(withProviderId: subServiceId, isFav: .isFav) { [weak self] (error, data) in
                self?.hideLoading()
                guard error == nil else {
                    self?.alertUser(title: "Error", message: error ?? "")
                    return
                }
                self?.favButton.setImage(#imageLiteral(resourceName: "faviconact"), for: .normal)
            }
        } else {
            
            bookngService.favItem(withProviderId: subServiceId, isFav: .isFav) { [weak self] (error, data) in
                self?.hideLoading()
                guard error == nil else {
                    self?.alertUser(title: "Error", message: error ?? "")
                    return
                }
                self?.favButton.setImage(#imageLiteral(resourceName: "unfavorite"), for: .normal)
            }
        }
        serviceItemDetailsModel?.isFavourite.toggle()

    }
    
    @IBAction func ServicesAction(_ sender: UIButton) {
        sender.backgroundColor = UIColor.init(displayP3Red: 243/255, green: 116/255, blue: 33/255, alpha: 1.0)
        detailsBtn.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
        reviewsBtn.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
        
    }
    
    @IBAction func detailsAction(_ sender: UIButton) {
            sender.backgroundColor = UIColor.init(displayP3Red: 243/255, green: 116/255, blue: 33/255, alpha: 1.0)
             servBtn.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
           reviewsBtn.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
    }
    @IBAction func reviewsActionBtn(_ sender: UIButton) {
         sender.backgroundColor = UIColor.init(displayP3Red: 243/255, green: 116/255, blue: 33/255, alpha: 1.0)
          detailsBtn.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
          servBtn.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK: - API Calls
    var bookngService = BookingServices()
    var bookingServiceDetailsModel :SubServiceDefaultResponse?
    var serviceItemDetailsResponseModel: ServiceItemDetailsResponseModel?
    private func getSubServiceInfo () {
        self.showLoading()
        bookngService.getServices(sub_service_id: self.subServiceId) { [weak self](error: String?, data: ServiceItemDetailsResponseModel?) in
            self?.hideLoading()
            if let error = error{
                self?.alertUser(title: "", message: error)
                return
            }
            self?.serviceItemDetailsResponseModel = data
            self?.initScrollView()
            self?.tbView.reloadData()
        }
    }

}

extension ServiceItemDetailsViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ServiceItemDetailsTableViewCell else {
                 return UITableViewCell()
              }
        cell.selectionStyle = .none
        guard let data = serviceItemDetailsResponseModel else {
            return cell
        }
        cell.serviceNameLabel.text = data.defaultResponse?.subService?.serviceName ?? ""
        cell.priceLabel.text = "\(data.defaultResponse?.subService?.price ?? 0)"
        cell.serviceDescriptionLabel.text = data.defaultResponse?.subService?.subServiceDescription
        cell.delegate = self
        return cell
    }
    
}
extension ServiceItemDetailsViewController: ServiceItemDetailsDelegate {
    func bookService(cell: UITableViewCell) {
        let index = tbView.indexPath(for: cell)
        print(index?.row ?? 0)
        let detailsVC = Initializer.createViewController(storyBoard: .HomeSB, andId: "BookingViewController") as! BookingViewController
        detailsVC.resources = serviceItemDetailsResponseModel?.defaultResponse?.resources?.data
        detailsVC.serviceItemDetailsResponseModel = serviceItemDetailsResponseModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}
