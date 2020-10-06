//
//  SearchNavigator.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/21/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class SearchNavigator: Navigator {
    
    // MARK: viewControllers id
    private let subcategoriesId = "SubCategoriesVC"
    private let servicesSubCategoriesId = "ServicesSubCategoriesVC"
    private let providerServicesId = "ProviderServicesVC"
    private let filterSideMenuId = "FilterSideMenuVC"
    
    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
        case subCategories(categoryId: Int?, categoryName: String?)
        case servicesSubCategories(subCategoryId: Int?, subCategoryName: String?)
        case filterSideMenu
        case providerServices(serviceId: Int?, searchByCategoryValidate: Bool?)
        case providerServicesFromSearch(searchkey: String?, cityDistrict: Int?, date: String?, time: String?)
    }
    
    // In most cases it's totally safe to make this a strong
    // reference, but in some situations it could end up
    // causing a retain cycle, so better be safe than sorry :)
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializer
    init(nav: UINavigationController?) {
        guard let nav = nav else { return }
        self.navigationController = nav
    }
    
    // MARK: - Navigator
    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .subCategories(let id, let name):
            return subCategoriesVC(categoryId: id!, categoryName: name!)
        case .servicesSubCategories(let subCategoryId, let subCategoryName):
            return servicesSubCategoriesVC(subCategoryId: subCategoryId!, subCategoryName: subCategoryName!)
        case .providerServices(let serviceId, let searchByCategoryValidate):
            return providerServicesVC(serviceId: serviceId!, searchByCategory: searchByCategoryValidate!)
        case .filterSideMenu:
            return filterSideMenuVC()
        case .providerServicesFromSearch(let keyword, let cityDistrict, let date, let time):
            return providerServicesFromSearchVC(keyword: keyword,cityDistrict: cityDistrict , date: date ,time: time)
            
        }
    }
    
    
    private func subCategoriesVC(categoryId: Int, categoryName: String) -> UIViewController{
        let id = subcategoriesId
        let nextVC = Initializer.createViewController(storyBoard: .SearchSB , andId: id) as! SubCategoriesVC
        nextVC.categoryId = categoryId
        nextVC.categoryName = categoryName
        //nextVC.delgate
        return nextVC
    }
    
    private func servicesSubCategoriesVC(subCategoryId: Int, subCategoryName: String) -> UIViewController{
        let id = servicesSubCategoriesId
        let nextVC = Initializer.createViewController(storyBoard: .SearchSB , andId: id) as! ServicesSubCategoriesVC
        nextVC.subCategoryId = subCategoryId
        nextVC.subCategoryName = subCategoryName
        return nextVC
    }
    
    private func filterSideMenuVC() -> UIViewController{
        let id = filterSideMenuId
        let nextVC = Initializer.createViewController(storyBoard: .SearchSB, andId: id) as! FilterSideMenuVC
        // nextVC.servicesId = servicesId
        return nextVC
    }
    
    private func providerServicesVC(serviceId: Int, searchByCategory: Bool) -> UIViewController{
        let id = providerServicesId
        let nextVC = Initializer.createViewController(storyBoard: .SearchSB, andId: id) as! ProviderServicesVC
        nextVC.servicesId = serviceId
        nextVC.searchByCategory = searchByCategory
        return nextVC
    }

    private func providerServicesFromSearchVC(keyword: String?,cityDistrict: Int? , date: String? ,time: String?) -> UIViewController{
        let id = providerServicesId
        let nextVC = Initializer.createViewController(storyBoard: .SearchSB, andId: id) as! ProviderServicesVC
        nextVC.searchKeyword = keyword!
        nextVC.cityDistrict = cityDistrict!
        nextVC.date = date!
        nextVC.time = time!
        return nextVC
    }
    
//    private func providerServicesFromSearchVC(providerServicesData: [HomeProvidersDatum]) -> UIViewController{
//        let id = showMapId
//        let nextVC = Initializer.createViewController(storyBoard: .SearchResultSB, andId: id) as! ShowMapVC
//       // nextVC.modalPresentationStyle = .overFullScreen
//        nextVC.modalTransitionStyle = .crossDissolve
//        nextVC.providerServicesData = providerServicesData
//        //viewController?.present(nextVC, animated: true, completion: nil)
//        return nextVC
//    }
//    
    
    
    
    
}
