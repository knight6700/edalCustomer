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
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationBar()
        
    }
    
    func tableViewConfiguration(){
        bookingTable.delegate = self
        bookingTable.dataSource = self
        bookingTable.register(UINib(nibName: "BookingCell", bundle: nil), forCellReuseIdentifier: "BookingCell")
    }
    
    func getUpcomingBooking(){
        
    }
    
    func getBookingHistory(){
        
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
