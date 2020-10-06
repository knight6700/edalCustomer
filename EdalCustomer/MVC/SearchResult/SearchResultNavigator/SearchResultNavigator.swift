//
//  SearchResultDetailsNavigator.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/21/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class SearchResultNavigator: Navigator {
    
    // MARK: viewControllers id
    private let showMapId = "ShowMapVC"
    private let providerDetailsId = "ProviderDetailsVC"
    private let providerDetailsServicesId = "ProviderDetailsServicesVC"
    private let providerDetailsReviewId = "ProviderDetailsReviewVC"
    private let providerDetailsDetailsId = "ProviderDetailsServicesVC"
    
    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
        case providerDetails    }
    
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
        case .providerDetails:
            return getProviderDetailsVC()
        }
    }
    
    private func getProviderDetailsVC() -> UIViewController{
        let id = providerDetailsId
        let vc = Initializer.createViewController(storyBoard: .BusinessProfileSB, andId: id) as! ProviderDetailsVC
        return vc
    }
    
    
  
}
