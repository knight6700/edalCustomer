//
//  SorryVC.swift
//  edalCustomerTest
//
//  Created by Mohamed Kelany on 7/31/18.
//  Copyright © 2018 Mohamed Kelany. All rights reserved.
//

import UIKit

class SorryPopUpVC: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var closeButton: UIButton!

    @IBOutlet weak var sorryLabel: UILabel!
    
    @IBOutlet weak var sorryDescriptionLabel: UILabel!
    // MARK: Properties
    
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // handleLocalization()
        configuration()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    func configuration(){
        
    }
    
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
        
    }
    
    // handleLocalization: to handle ar & en for the design
    func handleLocalization(){
       // self.title = "New_Title".localiz()

        sorryLabel.text = "Sor_SorryLabel".localize()
        sorryDescriptionLabel.text = "Sor_SorryDescriptionLabel".localize()
        closeButton.setTitle("Sor_CloseButton".localize(), for: .normal)
        
        
       

    }
    
    func handleNavigationBar(){
        
    }
    
    // MARK: Actions
    @IBAction func onTapClose(_ sender: UIButton) {
    }

}
