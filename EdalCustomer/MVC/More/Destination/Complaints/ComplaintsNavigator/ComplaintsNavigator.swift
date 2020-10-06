//
//  ComplaintsNavigator.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 9/11/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

class ComplaintsNavigator: Navigator {
    
    // MARK: viewControllers id
    private let complaintsListId = "ComplaintsListVC"
    private let complaintsInfoId = "ComplaintsInfoVC"
    
    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
        case complaintsList
        case complaintsInfo
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
        case .complaintsList:
            return getComplaintsListVC()
        case .complaintsInfo:
            return getComplaintsInfoVC()
        }
    }
    
    private func getComplaintsListVC() -> UIViewController{
        let id = complaintsListId
        let nextVC = Initializer.createViewController(storyBoard: .ComplaintsSB, andId: id) as! ComplaintsListVC
        return nextVC
    }
    private func getComplaintsInfoVC() -> UIViewController{
        let id = complaintsInfoId
        let nextVC = Initializer.createViewController(storyBoard: .ComplaintsSB, andId: id) as! ComplaintsInfoVC
        return nextVC
    }
    
}
