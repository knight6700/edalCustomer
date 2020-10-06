//
//  ExploreCollectionViewCell.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/14/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import Cosmos


protocol ExploreCellDelegate : class {
    func didPressFavButton(cell: ExploreCollectionViewCell)
    func didPressItemButton(index: Int)
    
}
class ExploreCollectionViewCell: UICollectionViewCell {

    
     weak var exploreCellDelegate: ExploreCellDelegate?
    @IBOutlet weak var businessNameLabel: UILabel!
    
    @IBOutlet weak var categoriesNameLabel: UILabel!
    @IBOutlet weak var businessImageView: UIImageView!
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var exploreCategoriesView: UIView!
    
    @IBOutlet weak var categoriesRateView: CosmosView!
    
    @IBOutlet weak var maxValuePriceLabel: UILabel!
    @IBOutlet weak var minValuePriceLabel: UILabel!
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var imagesCountLabel: UILabel!
    
    @IBOutlet weak var FavButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupGradient()
        setupUI()
    }
    
    func setupGradient()
    {
        // Call this in layoutSubView or viewDidLoad
        self.bgImageView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let width = self.bounds.width
        let height = self.bounds.height
        let sHeight:CGFloat = 60.0
        let shadow = UIColor.black.withAlphaComponent(0.6).cgColor
        
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

    func setupUI() {
        exploreCategoriesView.roundView(withCorner: 4.0)
        bgImageView.roundView(withCorner: 4.0)
        categoriesRateView.settings.updateOnTouch = false
    }
    
    @IBAction func onTappedFavButton(_ sender: UIButton) {
        exploreCellDelegate?.didPressFavButton(cell: self)
    }
        

}
