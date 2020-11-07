//
//  MoreVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/23/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class MoreVC: UIViewController {

    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var picView: UIView!
    var navigator:MoreNavigator? {
        let navigator = MoreNavigator(nav: self.navigationController)
        return navigator
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = "\(Defaults.FirstName) \(Defaults.LastName)"
        userEmail.text = Defaults.Email
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.262745098, green: 0.5019607843, blue: 0.7607843137, alpha: 1)
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        UIApplication.statusBarBackgroundColor = UIColor.blueColor()
        picView.backgroundColor = UIColor.blueColor()
        scrollView.backgroundColor = UIColor.blueColor()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
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
    
    func logout() {
        self.showLoading()
        let services = AuthenticationServices()
        services.logout { (error) in
           // sleep(1)
            self.hideLoading()
            if let error = error {
                self.alertUser(title: "", message: error)
            }
            Defaults.token = "not yet"
            Defaults.SocialId = ""
            Defaults.SocialToken = ""
            Defaults.SocialProvider = ""
            
            Router().toAuthenticationVC()
        }
    }
    
    @IBAction func onTappedPersonalInfo(_ sender: UIButton) {
        navigator?.navigate(to: .personalInfo)
    }
    
    @IBAction func onTappedLogout(_ sender: UIButton) {
            logout()
    }
    
    
    @IBAction func onTappedFavorite(_ sender: Any) {
        navigator?.navigate(to: .favoriteList)
    }
    
    @IBAction func onTappedComplaints(_ sender: Any) {
        navigator?.navigate(to: .complaints)

    }
    
    @IBAction func onTappedPaymentInformation(_ sender: Any) {
        navigator?.navigate(to: .paymentInfo)
    }
    
    @IBAction func onTappedSettings(_ sender: Any) {
        navigator?.navigate(to: .setting)
    }
    
    @IBAction func onTappedHelpCenter(_ sender: Any) {
        navigator?.navigate(to: .serviceItemdetail)
    }
    
}
