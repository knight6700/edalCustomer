//
//  CategoryItemsCell.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/20/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class CategoryItemsCell: UICollectionViewCell {
    @IBOutlet weak var searchByCategoriesView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    @IBOutlet weak var fullView: UIView!
    
    let blueColor = UIColor.init(red: 76/255, green: 130/255, blue: 200/255, alpha: 1.0)
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI() {
        //        searchByCategoriesView.layer.shadowOpacity = 0.7
        //        searchByCategoriesView.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        //        searchByCategoriesView.layer.shadowRadius = 5.0
        //        searchByCategoriesView.layer.shadowColor = UIColor.black.cgColor
        
        
        
//        searchByCategoriesView.roundView(withCorner: 13.0, borderColor: UIColor.init(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0), borderWidth: 0.5)
//        searchByCategoriesView.dropShadow(color: .gray, opacity: 0.5, offSet: CGSize(width: 1, height: 1), radius: 3, scale: true)
        
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchByCategoriesViewTapAction(sender:)))
        searchByCategoriesView.addGestureRecognizer(tapGestRecognizer)
        
        //        searchByCategoriesView.layer.shadowOffset = .zero
        //        searchByCategoriesView.layer.shadowOpacity = 0.6
        //        searchByCategoriesView.layer.shadowColor = UIColor.lightGray.cgColor
        //        searchByCategoriesView.layer.shadowRadius = 10.0
        //        searchByCategoriesView.layer.shadowPath = UIBezierPath(rect: searchByCategoriesView.bounds).cgPath
        //        searchByCategoriesView.layer.shouldRasterize = true
    }
    
    func configuration() {
        
    }
    
    @objc func searchByCategoriesViewTapAction(sender: UITapGestureRecognizer) {
        searchByCategoriesView.roundView(withCorner: 13.0, borderColor: UIColor.init(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0), borderWidth: 0.5)
        categoryImageView.tintColor = blueColor
        //searchByCategoriesView
      //  delegate?.searchByCategoriesViewTapped(cell: self)
    }
    
    

}
