//
//  ComplaintsListVC.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 9/11/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class ComplaintsListVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
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
        
        let nib = UINib.init(nibName: "ComplaintsCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 80
        tableView.estimatedRowHeight = 80
        
    }
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
        
    }
    
    // MARK: Actions
}


// MARK: UITableViewDelegate, UITableViewDataSource
extension ComplaintsListVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navigator = ComplaintsNavigator(nav: self.navigationController)
        navigator.navigate(to: .complaintsInfo)
    }
}

