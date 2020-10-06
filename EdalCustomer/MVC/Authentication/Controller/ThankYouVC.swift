//
//  ThankYouVC.swift
//  edalCustomerTest
//
//  Created by Mohamed Kelany on 7/31/18.
//  Copyright © 2018 Mohamed Kelany. All rights reserved.
//

import UIKit

class ThankYouVC: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var closeButton: UIButton!

    @IBOutlet weak var thankYouLabel: UILabel!
    
    @IBOutlet weak var anotherThankYouLabel: UILabel!
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
        closeButton.roundView(withCorner: closeButton.frame.height/2)
    }
    
    // handleLocalization: to handle ar & en for the design
    func handleLocalization(){
        thankYouLabel.text = "Tha_ThankYouLabel".localize()
        anotherThankYouLabel.text = "Tha_anotherThankYouLabel".localize()
        closeButton.setTitle("Tha_CloseButton".localize(), for: .normal)
    }
    
    // MARK: Actions
    @IBAction func onTapClose(_ sender: UIButton) {
       
        let navigator = AuthNavigator(nav: self.navigationController)
        navigator.navigate(to: .profile)
        
    }
    

}
