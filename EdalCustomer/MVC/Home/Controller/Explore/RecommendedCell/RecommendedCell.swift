//
//  RecommendedCell.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/22/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import Cosmos


protocol RecommendedCellDelegate : class {
    func didPressFavButton(cell: RecommendedCell)
}
class RecommendedCell: UITableViewCell {

    
    weak var recommendedDelegate: RecommendedCellDelegate?

    
    @IBOutlet weak var businessNameLabel: UILabel!
    
    @IBOutlet weak var categoriesNameLabel: UILabel!
    @IBOutlet weak var businessImageView: UIImageView!
    

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var recommendedCategoriesView: UIView!
    
    @IBOutlet weak var categoriesRateView: CosmosView!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var maxValuePriceLabel: UILabel!
    @IBOutlet weak var minValuePriceLabel: UILabel!
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var imagesCountLabel: UILabel!
    private var gradient: CAGradientLayer!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupGradient()
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        categoriesRateView.settings.updateOnTouch = false
    }
    
    @IBAction func onTappedFavButton(_ sender: UIButton) {
        recommendedDelegate?.didPressFavButton(cell: self)
    }
}
