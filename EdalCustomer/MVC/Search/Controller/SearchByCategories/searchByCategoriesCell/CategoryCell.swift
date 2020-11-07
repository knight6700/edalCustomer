//
//  CategoryCell.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/20/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    
    var categoriesObject: [CategoriesData]! {
        didSet {
            categoryItemscollectionView.delegate = self
            categoryItemscollectionView.dataSource = self

        }
    }
    @IBOutlet weak var categoryItemscollectionView: UICollectionView!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    
    let blueColor = UIColor.init(red: 76/255, green: 130/255, blue: 200/255, alpha: 1.0)
    let shadowsColor = UIColor.init(red: 134/255, green: 134/255, blue: 134/255, alpha: 0.3)
    let bordersColor = UIColor.init(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      setupViews()
    }
    
 
    func setupViews(){
         self.categoryItemscollectionView.register(UINib(nibName: "CatItemsCell", bundle: nil), forCellWithReuseIdentifier: "CatItemsCell")
       //// categoryItemscollectionView.reloadData()
       categoryItemscollectionView.allowsMultipleSelection = false
        indicatorActivity.startAnimating()
       // categoryItemscollectionView.register(CatItemsCell.self, forCellWithReuseIdentifier: "CatItemsCell")
    }
    func returnDate(stopPagination: Bool, data:[CategoriesData])
    {
        print(stopPagination)
//        self.categoriesObject.removeAll()
        if !stopPagination {
            self.categoriesObject = data
            print("categoriesObject",self.categoriesObject)
            categoryItemscollectionView.reloadData()
            if data.count > 0{
            indicatorActivity.stopAnimating()
            }
            //self.categoriesObject.removeAll()
        } else {
           // stopPagination = false
            self.categoriesObject.removeAll()
           // return
        }

    }
}
extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.frame.height-20)/3
        let width = (UIScreen.main.bounds.width - 20) / 3
        return CGSize(width: CGFloat(width), height: CGFloat(height) )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 7, left: 0, bottom: 5, right: 0)
    }
    
}
extension CategoryCell: UICollectionViewDelegate {
    
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("//////")
        let cell = collectionView.cellForItem(at: indexPath) as! CatItemsCell
        cell.searchByCategoriesView.roundView(withCorner: 13.0, borderColor: bordersColor, borderWidth: 0.5)
        cell.categoryImageView.tintColor = .white
        cell.searchByCategoriesView.dropShadow(color: shadowsColor, opacity: 0.2, offSet: CGSize(width: 1, height: 1), radius: 0.5, scale: true)
        cell.searchByCategoriesView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.searchByCategoriesView.roundView(withCorner: 13.0, borderColor: bordersColor, borderWidth: 0.5)
        cell.categoryImageView.image = cell.categoryImageView.image?.withRenderingMode(.alwaysTemplate)
        cell.categoryImageView.tintColor = UIColor.white
       // cell.categoryImageView.tintColor = UIColor.white
        cell.categoryTitle.textColor = UIColor.white
        DispatchQueue.main.async {
            let navigator = SearchNavigator(nav: SingletonClass.shared.searchNav)
            navigator.navigate(to: .subCategories(categoryId: self.categoriesObject[indexPath.item].id, categoryName: self.categoriesObject[indexPath.item].name))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CatItemsCell
        cell.searchByCategoriesView.backgroundColor = .white
        cell.categoryTitle.textColor = UIColor.lightGray
        cell.searchByCategoriesView.roundView(withCorner: 13.0, borderColor: bordersColor, borderWidth: 0.5)
        cell.categoryImageView.image = cell.categoryImageView.image!.withRenderingMode(.alwaysTemplate)
        cell.categoryImageView.tintColor = blueColor
        cell.searchByCategoriesView.dropShadow(color: shadowsColor, opacity: 0.2, offSet: CGSize(width: 1, height: 1), radius: 0.5, scale: true)
    }
    
}
extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesObject.count//categoriesObject.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryItemscollectionView.dequeueReusableCell(withReuseIdentifier: "CatItemsCell", for: indexPath) as! CatItemsCell
        print(indexPath.item)
        let category = categoriesObject[indexPath.row]
        cell.searchByCategoriesView.backgroundColor = .white
        cell.categoryTitle.textColor = UIColor.lightGray
        cell.categoryImageView.addImage(withImage: category.icon ?? "", andPlaceHolder: "coursss")
        cell.categoryTitle.text = category.name ?? ""
       // cell.searchByCategoriesView.roundView(withCorner: 13.0, borderColor: bordersColor, borderWidth: 0.5)

       // cell.searchByCategoriesView.addCategoryShadow() 
//        let categoryImageUrl = URL(string: categoriesObject[indexPath.item].icon!)
//        if categoryImageUrl != nil
//        {
//            print("image_url:\(String(describing: categoryImageUrl))")
//            cell.categoryImageView.load(url: categoryImageUrl!, color: blueColor)
//        }
//        cell.categoryTitle.text = categoriesObject[indexPath.item].name
        cell.backgroundColor = .clear
        return cell
    }
    
    
}
