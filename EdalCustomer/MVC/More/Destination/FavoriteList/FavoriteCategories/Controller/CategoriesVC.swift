//
//  CategoriesVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/18/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

//protocol CategoriesVCDelegate {
//    func getAllCategories(_ controller: CategoriesVC, categoriesData : [Datam])
//}

class CategoriesVC: UIViewController {
    
    //MARK:- Properties & Outlets
    
    //Properties
    var categoriesData = [CategoriesData]()
    var selectedCategoriesData = [CategoriesData]()
    var selectedCategoriesId = [Int]()
    var CategoriesTotalpages: Int = 1
    var current_page: Int = 1
    var bubblePickerNode: BubblePickerNode?
    var paginationCategoriesData = [CategoriesData]()
   // var allCategoriesDelegate : CategoriesVCDelegate! = nil
    //outlets
    @IBOutlet weak var bubblePicker: BubblePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideLoading()
        bubblePicker.delegate = self
       // bubblePicker.
        gettotalPagesofCategories()
        print("total",CategoriesTotalpages)
        loadMoreCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func onTappedReset(_ sender: UIButton) {

        selectedCategoriesData.removeAll()
        bubblePickerNode?.setSelected(false)
        bubblePicker.nodes.removeAll()
        let subViews = self.bubblePicker.subviews
        for subview in subViews as [UIView]   {
            subview.removeFromSuperview()
        }
       bubblePicker.reloadData()
        print(selectedCategoriesData)
    }
    
    @IBAction func onTappedNext(_ sender: UIButton) {
        print("next button tapped")
        if selectedCategoriesId.count > 0 {
        updateFavCategories(selectedCategoriesId: selectedCategoriesId)
        } else {
            print("no items selected")
        }
        
       // saveCategories()
        
        let navigator = ProfileNavigator(nav: self.navigationController)
        navigator.navigate(to: .home)
    }
    
    func gettotalPagesofCategories(){
        let services = CategoriesServices()
        services.getAllCategories(for: current_page, completion: { (error, data) in
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let _data = data else{return}
            
            self.CategoriesTotalpages = ((_data.paginated_categories?.meta?.pagination?.total_pages)!)
        })
    }
    
    
    
    //MARK: fetchMoreCategories
    func loadMoreCategories(){
        
        if current_page == self.CategoriesTotalpages {
            getAllCategories(for: current_page)
            //  self.hideLoading()
            //return
        }
        if current_page > self.CategoriesTotalpages {
            //self.hideLoading()
            return
        }
        while current_page < CategoriesTotalpages {
            if paginationCategoriesData.count > 0 {
                print("go to get more categories")
                getAllCategories(for: current_page)
                current_page += 1
                print("page:\(current_page)")
            }
        }
    }
    
    func getAllCategories(for page: Int) {
        self.showLoading()
        let services = CategoriesServices()
        services.getAllCategories(for: page, completion: { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let _data = data else{return}
            self.categoriesData = (_data.categories?.data)!
           // self.paginationCategoriesData = _data.paginated_categories.data
            //self.fillSubCollectionViewsData(categoriesData: self.categoriesData)
            //self.searchByCategoriesCollectionView.reloadData()
            //  print(categoriesData)
            //self.firstCollectionView.reloadData()
            //self.secondCollectionView.reloadData()
            //self.thirdCollectionView.reloadData()
            //self.fourthCollectionView.reloadData()
            self.bubblePicker.reloadData()
            print(self.categoriesData)
            print(self.paginationCategoriesData)
            
            
        })
    }

    
    func updateFavCategories(selectedCategoriesId:[Int]) {
        let services = CategoriesServices()
        services.updateFavoriteCategory(withCategoriesIds: selectedCategoriesId, completion: { (error, data) in
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let _ = data else{return}
            
            print(self.categoriesData)
            
            
        })
    }
    
    func saveCategories(){
//        guard let categoriesData = self.categoriesData else {return}
//        let categoriesArray = self.categoriesData
//        let categoriesData = NSKeyedArchiver.archivedData(withRootObject: categoriesArray)
//        UserDefaults.standard.set(categoriesData, forKey: "categories")
    }
}

extension CategoriesVC: BubblePickerDelegate {
    
    func numberOfItems(in bubblepicker: BubblePicker) -> Int {
        print(categoriesData.count)
        return (categoriesData.count)
        
    }
    //let categoryImageUrl = URL(string: thirdCollectionViewData[indexPath.item].icon!)
    func bubblePicker(_: BubblePicker, nodeFor indexPath: IndexPath) -> BubblePickerNode {
        let node = BubblePickerNode(title: categoriesData[indexPath.item].name ?? "", color: .white, imageUrl: "\(categoriesData[indexPath.item].icon ?? "no node")")
        
        return node
        
    }
    
    func bubblePicker(_: BubblePicker, didSelectNodeAt indexPath: IndexPath) {
        print("Did select")
       // if selectedCategoriesData.count > 5 {
            selectedCategoriesData.insert(categoriesData[indexPath.item], at: 0)
        selectedCategoriesId.insert(categoriesData[indexPath.item].id!, at: 0)
            print(selectedCategoriesData)
            print(selectedCategoriesId)
//        } else {
//            return
//        }
        
        
        
    }
    
    func bubblePicker(_: BubblePicker, didDeselectNodeAt indexPath: IndexPath) {
        print("Did deselect")
        if let i = selectedCategoriesData.index(where: { $0.id == indexPath.item }) {
            selectedCategoriesData.remove(at: i)
            selectedCategoriesId.remove(at: i)
        }
        print(selectedCategoriesData)
        print(selectedCategoriesId)
        
        
    }
    
}
