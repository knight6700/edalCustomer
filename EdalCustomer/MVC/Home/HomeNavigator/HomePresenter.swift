//
//  HomePresenter.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/19/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter{
    
    // MARK: viewControllers id
  
    
    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
       
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
       
        }
    }
   
}
