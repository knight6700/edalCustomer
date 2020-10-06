//
//  ComplaintsPresenter.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 9/11/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

class ComplaintsPresenter{
    
    // MARK: viewControllers id
    private let reopenComplaintId = "ReopenComplaintVC"
    
    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
        case reopenComplaint
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
        case .reopenComplaint:
            presentReopenComplaint()
        }
    }
    
    private func presentReopenComplaint(){
        let id = reopenComplaintId
        let nextVC = Initializer.createViewController(storyBoard: .ComplaintsSB, andId: id) as! ReopenComplaintVC
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            self.viewController?.present(nextVC, animated: true, completion: nil)
        }
    }
}
