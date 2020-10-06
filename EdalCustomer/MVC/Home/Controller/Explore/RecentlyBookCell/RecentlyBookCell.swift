//
//  RecentlyBookCell.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/22/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import Cosmos

class RecentlyBookCell: UICollectionViewCell {
    
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var categoriesRateView: CosmosView!
    @IBOutlet weak var maxValuePriceLabel: UILabel!
    @IBOutlet weak var minValuePriceLabel: UILabel!

    @IBOutlet weak var RecentlyBookView: UIView!
    private var gradient: CAGradientLayer!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupGradient()
        setUpUI()
    }
    
    func setupGradient()
    {
        
        // Call this in layoutSubView or viewDidLoad
        self.bgImageView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let width = self.bounds.width
        let height = self.bounds.height
        let sHeight:CGFloat = 60.0
        let shadow = UIColor.black.withAlphaComponent(0.7).cgColor
        
        // Add gradient bar for image on top
        let topImageGradient = CAGradientLayer()
        topImageGradient.frame = CGRect(x: 0, y: 0, width: width, height: sHeight)
        topImageGradient.colors = [shadow, UIColor.clear.cgColor]
        bgImageView.layer.insertSublayer(topImageGradient, at: 0)
        
        let bottomImageGradient = CAGradientLayer()
        bottomImageGradient.frame = CGRect(x: 0, y: height - sHeight, width: width, height: sHeight)
        bottomImageGradient.colors = [UIColor.clear.cgColor, shadow]
        bgImageView.layer.insertSublayer(bottomImageGradient, at: 0)
        
        
    }
    
    func setUpUI() {
        RecentlyBookView.roundView(withCorner: 4.0)
        bgImageView.roundView(withCorner: 4.0)
        categoriesRateView.settings.updateOnTouch = false
    }


}
