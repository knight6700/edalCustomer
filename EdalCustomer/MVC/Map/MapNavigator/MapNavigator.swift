//
//  MapNavigator.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/26/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class MapNavigator: Navigator {
    
    // MARK: viewControllers id
    private let MapId = "MapVC"
    
    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
        case mapVC(from: UIViewController)
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
        case .mapVC(let vc):
            return getMapVC(with: vc)
        }
    }
    
    private func getMapVC(with currentVC: UIViewController) -> UIViewController{
        let id = MapId
        let nextVC = Initializer.createViewController(storyBoard: .MapSB, andId: id) as! MapVC
        nextVC.selectLocationDelegate = currentVC as? SelectLocationDataSource
        return nextVC
    }
    
}



















