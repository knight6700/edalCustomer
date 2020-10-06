//
//  HomeTabBarController.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/26/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {

    var centerButton: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.blueColor()

        //customzing center button
        if let newButtonImage = UIImage(named: "mainbotton") {
            self.addCenterButton(withImage: newButtonImage, highlightImage: newButtonImage)
        }
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        setupTabBarSeparators()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func handleNavigationBar(){
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

   
    func setupTabBarSeparators() {
         let itemWidth = floor(self.tabBar.frame.size.width / CGFloat(self.tabBar.items!.count))
         
         // this is the separator width.  0.5px matches the line at the top of the tab bar
         let separatorWidth: CGFloat = 0.5
         
         // iterate through the items in the Tab Bar, except the last one
         for i in 0...(self.tabBar.items!.count - 1) {
             guard i == 0 || i == 3 else {continue}
             
             // make a new separator at the end of each tab bar item
             let xPosition = itemWidth * CGFloat(i + 1) - CGFloat(separatorWidth / 2)
             let height = self.tabBar.frame.size.height
             let padding: CGFloat = 8
             let separator = UIView(frame: CGRect(x: xPosition, y: padding/2, width: separatorWidth, height: height - padding))
             
             // set the color to light gray (default line color for tab bar)
             separator.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
             
             self.tabBar.addSubview(separator)
         }
     }

    @objc func handleTouchTabbarCenter(){
        if let count = self.tabBar.items?.count
        {
            let i = floor(Double(count / 2))
            self.selectedViewController = self.viewControllers?[Int(i)]
        }
    }
    
    func addCenterButton(withImage buttonImage : UIImage, highlightImage: UIImage) {
        
        self.centerButton = UIButton(type: .custom)
        self.centerButton?.autoresizingMask = [.flexibleRightMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin]
        self.centerButton?.frame = CGRect(x: 0.0, y: 0.0, width: buttonImage.size.width, height: buttonImage.size.height)
        self.centerButton?.setBackgroundImage(buttonImage, for: .normal)
        self.centerButton?.setBackgroundImage(highlightImage, for: .highlighted)
        self.centerButton?.isUserInteractionEnabled = true
        
        let heightdif: CGFloat = buttonImage.size.height - (self.tabBar.frame.size.height);
        
        if (heightdif < 0){
            self.centerButton?.center = (self.tabBar.center)
        }
        else{
            var center: CGPoint = (self.tabBar.center)
            center.y = center.y - 24
            self.centerButton?.center = center
        }
        
        self.view.addSubview(self.centerButton!)
        self.tabBar.bringSubviewToFront(self.centerButton!)
        
        self.centerButton?.addTarget(self, action: #selector(handleTouchTabbarCenter), for: .touchUpInside)
        
        if let count = self.tabBar.items?.count
        {
            let i = floor(Double(count / 2))
            let item = self.tabBar.items![Int(i)]
            item.title = ""
        }
    }
    
    


}
