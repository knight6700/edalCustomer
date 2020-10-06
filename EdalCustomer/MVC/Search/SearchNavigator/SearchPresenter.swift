//
//  SearchPresenter.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/21/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

class SearchPresenter{
    
    // MARK: viewControllers id
    private let showMapId = "ShowMapVC"
    
    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
        case ShowOnMap(providerDetailsData: [HomeProvidersDatum])
    }
    
    // In most cases it's totally safe to make this a strong
    // reference, but in some situations it could end up
    // causing a retain cycle, so better be safe than sorry :)
    private weak var viewController: UIViewController?
    
    // MARK: - Initializer
    init(vc: UIViewController?) {
        guard let vc = vc else { return }
        self.viewController = vc
    }
    
    // MARK: - Navigator
    func present(_ destination: Destination) {
        presentViewController(for: destination)
    }
    
    // MARK: - Private
    private func presentViewController(for destination: Destination) {
        switch destination {
        case .ShowOnMap(let providersData):
            ShowOnMapVC(providerServicesData: providersData)
        }
    }

    private func ShowOnMapVC(providerServicesData: [HomeProvidersDatum]){
        let id = showMapId
        let nextVC = Initializer.createViewController(storyBoard: .SearchResultSB, andId: id) as! ShowMapVC
       // nextVC.modalPresentationStyle = .overFullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.providerServicesData = providerServicesData
        viewController?.present(nextVC, animated: true, completion: nil)
    }
   
}

