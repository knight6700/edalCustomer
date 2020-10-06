//
//  SortingPopupVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/19/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import SideMenu

protocol SortingPopupVCDelegate {
    func onTappedSorttingItem(highToLowPrice: Bool, lowToHighPrice: Bool,  topRated: Bool, aToZ: Bool)
}

class SortingPopupVC: UIViewController {

    @IBOutlet weak var highToLowPriceImageView: UIImageView!
    @IBOutlet weak var lowToHighPriceImageView: UIImageView!
    @IBOutlet weak var topRatedImageView: UIImageView!
    @IBOutlet weak var aToZImageView: UIImageView!
    @IBOutlet weak var dismissBlurButton: UIButton!
    @IBOutlet weak var sortingByView: UIView!
    @IBOutlet weak var highToLowPriceView: UIView!
    @IBOutlet weak var lowToHighPriceView: UIView!
    @IBOutlet weak var toRatedView: UIView!
    @IBOutlet weak var aToZView: UIView!
    var highToLowPrice: Bool = false
    var lowToHighPrice: Bool = false
    var topRated: Bool = false
    var aToZ: Bool = false
    
    var delegate: SortingPopupVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configurationSortingTapped()
        // Set up a cool background image for demo purposes
//        let imageView = UIImageView(image: UIImage(named: "saturn"))
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
//        let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .viewSlideInOut, .menuDissolveIn]
       
    }
    
    func configurationSortingTapped() {
        let highPriceTapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTappedHighToLowPriceItem(sender:)))
        highToLowPriceView.addGestureRecognizer(highPriceTapGestRecognizer)
        
        let lowPriceTapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTappedLowToHighPriceItem(sender:)))
        lowToHighPriceView.addGestureRecognizer(lowPriceTapGestRecognizer)
        
        let topRatedTapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTappedTopRatedItem(sender:)))
        toRatedView.addGestureRecognizer(topRatedTapGestRecognizer)
        
        let aToZTapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTappedAToZItem(sender:)))
        aToZView.addGestureRecognizer(aToZTapGestRecognizer)
    }
    
    @objc func onTappedHighToLowPriceItem(sender: UITapGestureRecognizer){
        
        highToLowPriceImageView.isHidden = false
        
        highToLowPrice = false
        lowToHighPrice = true
        topRated = true
        aToZ = true
        hideItems(highToLowPrice: false, lowToHighPrice: true, topRated: true, aToZ: true)
        
    }
    
    @objc func onTappedLowToHighPriceItem(sender: UITapGestureRecognizer){
        lowToHighPriceImageView.isHidden = false
        
        lowToHighPrice = false
        highToLowPrice = true
        topRated = true
        aToZ = true
        hideItems(highToLowPrice: true, lowToHighPrice: false, topRated: true, aToZ: true)
        //delegate?.onTappedSorttingItem(highToLowPrice: true, lowToHighPrice: false, topRated: true, aToZ: true)
       // self.dismiss(animated: true, completion: nil)
    }
    @objc func onTappedTopRatedItem(sender: UITapGestureRecognizer){
        topRatedImageView.isHidden = false
        

        highToLowPrice = true
        lowToHighPrice = true
        topRated = false
        aToZ = true
        hideItems(highToLowPrice: true, lowToHighPrice: true, topRated: false, aToZ: true)
      //  delegate?.onTappedSorttingItem(highToLowPrice: true, lowToHighPrice: true, topRated: false, aToZ: true)
       // self.dismiss(animated: true, completion: nil)
    }
    @objc func onTappedAToZItem(sender: UITapGestureRecognizer){
        aToZImageView.isHidden = false
        
        highToLowPrice = true
        lowToHighPrice = true
        topRated = true
        aToZ = false
        hideItems(highToLowPrice: true, lowToHighPrice: true, topRated: true, aToZ: false)
      //  delegate?.onTappedSorttingItem(highToLowPrice: true, lowToHighPrice: true, topRated: true, aToZ: false)
    }
    
    func hideItems(highToLowPrice: Bool, lowToHighPrice: Bool, topRated: Bool, aToZ: Bool){
        highToLowPriceImageView.isHidden = highToLowPrice
        lowToHighPriceImageView.isHidden = lowToHighPrice
        topRatedImageView.isHidden = topRated
        aToZImageView.isHidden = aToZ
       // delegate?.onTappedSorttingItem(highToLowPrice: highToLowPrice, lowToHighPrice: lowToHighPrice, topRated: topRated, aToZ: aToZ)
    }
    
    

    func setupUI() {
        sortingByView.roundView(withCorner: 8)
        highToLowPriceImageView.isHidden = true
        lowToHighPriceImageView.isHidden = true
        topRatedImageView.isHidden = true
        aToZImageView.isHidden = true
        
    }
    
    
    @IBAction func onTappedDismissButton(_ sender: UIButton) {
       
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTappedDoneButton(_ sender: UIButton) {
         if highToLowPrice == false {
            delegate?.onTappedSorttingItem(highToLowPrice: false, lowToHighPrice: true, topRated: true, aToZ: true)
            self.dismiss(animated: true, completion: nil)
        }
        else if lowToHighPrice == false {
            delegate?.onTappedSorttingItem(highToLowPrice: true, lowToHighPrice: false, topRated: true, aToZ: true)
            self.dismiss(animated: true, completion: nil)
        }
        else if aToZ == false {
            delegate?.onTappedSorttingItem(highToLowPrice: true, lowToHighPrice: true, topRated: true, aToZ: false)
            self.dismiss(animated: true, completion: nil)
        }
        else{
            delegate?.onTappedSorttingItem(highToLowPrice: true, lowToHighPrice: true, topRated: false, aToZ: true)
            self.dismiss(animated: true, completion: nil)
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func onTappedCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
