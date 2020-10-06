//
//  CatItemsCell.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/21/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit


class CatItemsCell: UICollectionViewCell {
    @IBOutlet weak var searchByCategoriesView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var fullView: UIView!
    
//    let blueColor = UIColor.init(red: 76/255, green: 130/255, blue: 200/255, alpha: 1.0)
//    let shadowColor = UIColor.init(red: 134/255, green: 134/255, blue: 134/255, alpha: 0.3)
//    let borderColor = UIColor.init(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI() {
        searchByCategoriesView.backgroundColor = .white
        categoryTitle.textColor = UIColor.lightGray
//        searchByCategoriesView.roundView(withCorner: 13.0, borderColor: borderColor, borderWidth: 0.5)
//        searchByCategoriesView.dropShadow(color: shadowColor, opacity: 0.5, offSet: CGSize(width: 1, height: 1), radius: 0.5, scale: true)
        
        fullView.roundView(withCorner: 13.0)
       // searchByCategoriesView.roundView(withCorner: 13.0)
        //searchByCategoriesView.addCategoryShadow()
    }

}
