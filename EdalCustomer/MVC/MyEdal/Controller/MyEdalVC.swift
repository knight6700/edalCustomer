//
//  MyEdalVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/23/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

enum MyDeals {
    case upComing
    case history
}
class MyEdalVC: UIViewController {

    @IBOutlet weak var upcomingBookingsButton: UIButton!
    @IBOutlet weak var bookingHistoryButton: UIButton!
    
    @IBOutlet weak var bookingTable: UITableView!
    var data: UpCommingResponse?
    let services = MyEdalServices()
    var numberOfPage = 1
    var dealType = MyDeals.upComing
    var totamLimits = 10
    var isLoading = true
    var totalPages: Int {
        return self.data?.defaultResponse?.books?.meta?.pagination?.totalPages ?? 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getUpcomingBooking()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationBar()
        tableViewConfiguration()
    }
    
    func tableViewConfiguration(){
        bookingTable.delegate = self
        bookingTable.dataSource = self
        bookingTable.register(UINib(nibName: "MyDealsTableViewCell", bundle: nil), forCellReuseIdentifier: "MyDealsCell")
        bookingTable.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        bookingTable.separatorStyle = .none
        upcomingBookingsButton.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
        bookingHistoryButton.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
    }
    
    func addFooterReffresher() {
        guard !isLoading else { return }
            let totalPages = self.data?.defaultResponse?.books?.meta?.pagination?.totalPages ?? 0
            if self.numberOfPage <= totalPages {
                switch self.dealType {
                case .history :
                    self.getBookingHistory()
                case .upComing:
                    self.getUpcomingBooking()
                }
            }
    }
    
    func getUpcomingBooking(){
        self.showLoading()
        isLoading = true
        services.getUpcomingBooking(page: "\(numberOfPage)") { [weak self ](error, data) in
            self?.hideLoading()
            guard error == nil else {
                self?.alertUser(title: "Error", message: error ?? "")
                return
            }
            if self?.data == nil {
                self?.data = data
            }else {
                guard let array = data?.defaultResponse?.books?.data else {return}
                self?.data?.defaultResponse?.books?.data?.append(contentsOf: array)
            }
            DispatchQueue.main.async {
                self?.bookingTable.reloadData()
            }
            self?.numberOfPage += 1
            self?.isLoading = false
        }
    }
    
    func getBookingHistory(){
        self.showLoading()
        isLoading = true
        services.getHistoryServices(page: "\(numberOfPage)") { [weak self ](error, data) in
            self?.hideLoading()
            guard error == nil else {
                self?.alertUser(title: "Error", message: error ?? "")
                return
            }
            if self?.data == nil {
                self?.data = data
            }else {
                guard let array = data?.defaultResponse?.books?.data else {return}
                self?.data?.defaultResponse?.books?.data?.append(contentsOf: array)
            }
            DispatchQueue.main.async {
                self?.bookingTable.reloadData()
            }
            self?.numberOfPage += 1
            self?.isLoading = false
        }
    }
    
    @IBAction func bookingPressed(_ sender: UIButton) {
        data = nil
        numberOfPage = 1
        if sender.tag == 0 {
            dealType = .upComing
            getUpcomingBooking()
            upcomingBookingsButton.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
            bookingHistoryButton.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)

        }else {
            dealType = .history
            getBookingHistory()
            upcomingBookingsButton.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
            bookingHistoryButton.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)

        }
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

}

extension MyEdalVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MyEdalDetailsViewController()
        vc.data = data?.defaultResponse?.books?.data?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MyEdalVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = data?.defaultResponse?.books?.data?.count ?? 0
        if count  > 0 {
            tableView.backgroundView = nil
            guard  numberOfPage <= totalPages else {
                self.bookingTable.restore()
                return count
            }
            bookingTable.restore()
            return count + 1
        }else {
            self.bookingTable.setNoData()
            return count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingTableViewCell
        let totalPages = self.data?.defaultResponse?.books?.meta?.pagination?.totalPages ?? 0
        if indexPath.row == data?.defaultResponse?.books?.data?.count ?? 0 - 1 ,
            numberOfPage <= totalPages{
            cell.loadingIndicator.startAnimating()
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyDealsCell", for: indexPath) as? MyDealsTableViewCell else {
                return UITableViewCell()
            }
            guard let book = data?.defaultResponse?.books?.data?[indexPath.row] else {
                return cell
            }
            cell.dealImage.addImage(withImage:  book.providerImage ?? "", andPlaceHolder: "photoa")
            cell.dealTitleLabel.text = book.providerName ?? ""
            cell.dealDateLabel.text = book.startDate ?? ""
            cell.dealTimeLabel.text = "\(book.from ?? "") - \(book.to ?? "")"
            cell.dealStatusValueLabel.text = book.statusText ?? ""
            cell.priceLabel.text = "\(book.price ?? 0.0) EGP"
            cell.setStatusColor(id: book.status ?? 0)
            cell.backgroundColor = .clear
            return cell
        }
        return cell
    }
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !isLoading else { return }
            let totalPages = self.data?.defaultResponse?.books?.meta?.pagination?.totalPages ?? 0
            if numberOfPage <= totalPages {
                let array = self.data?.defaultResponse?.books?.data?.count ?? 0 - 1
                if indexPath.row  == array {
                    addFooterReffresher()
                }
            }

    }
    
}
