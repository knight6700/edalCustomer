//
//  MyEdalVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/23/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class MyEdalVC: UIViewController {

    @IBOutlet weak var upcomingBookingsButton: UIButton!
    @IBOutlet weak var bookingHistoryButton: UIButton!
    
    @IBOutlet weak var bookingTable: UITableView!
    var data: UpCommingResponse?
    let services = MyEdalServices()
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
        bookingTable.separatorStyle = .none
    }
    
    func getUpcomingBooking(){
        services.getUpcomingBooking(page: "1") { [weak self ](error, data) in
            self?.data = data
            self?.bookingTable.reloadData()
        }
    }
    
    func getBookingHistory(){
        
    }
    
    @IBAction func bookingPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            
        }else {
            
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
    
}

extension MyEdalVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.defaultResponse?.books?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        cell.backgroundColor = .clear
        return cell
    }
    
    
}
