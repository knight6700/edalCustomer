//
//  MoreNavigator.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/16/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class MoreNavigator: Navigator {
    
    // MARK: viewControllers id
    private let settingId = "SettingVC"
    private let favoriteListId = "FavoriteListVC"
    private let personalInfoId = "PersonalInfoVC"
    private let paymentInfoId = "PaymentInfoVC"
    private let mybalanceId = "MyBalanceVC"
    private let serviceItemdetail = "ServiceItemDetailsViewController"
    private let complaintsId = "ComplaintsVC"
   // private let profileId = "ProfileVC"
    
    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
        case setting
        case favoriteList
        case personalInfo
        case paymentInfo
        case mybalance
        case complaints
        case serviceItemdetail
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
        case .setting:
            return getSettingVC()
        case .favoriteList:
            return getFavoriteListVC()
        case .personalInfo:
            return getPersonalInfoVC()
        case .paymentInfo:
            return getPaymentInfoVC()
        case .mybalance:
            return getMybalanceVC()
        case .complaints:
            return getComplaintsVC()
        case .serviceItemdetail:
            return getItemDetailsVC()
        }
    }
    private func getSettingVC() -> UIViewController{
        let id = settingId
        let vc = Initializer.createViewController(storyBoard: .SettingSB, andId: id) as! SettingVC
        return vc
    }
    private func getFavoriteListVC() -> UIViewController{
        let id = favoriteListId
        let vc = Initializer.createViewController(storyBoard: .FavoriteListSB, andId: id) as! FavoriteListVC
        return vc
    }
    
    private func getPersonalInfoVC() -> UIViewController{
        let id = personalInfoId
        let vc = Initializer.createViewController(storyBoard: .ProfileSB, andId: id) as! PersonalInfoVC
        return vc
    }
    
    private func getPaymentInfoVC() -> UIViewController{
        let id = paymentInfoId
        let vc = Initializer.createViewController(storyBoard: .PaymentInfoSB, andId: id) as! PaymentInfoVC
        return vc
    }
    
    private func getMybalanceVC() -> UIViewController{
        let id = mybalanceId
        let vc = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! PasswordVC
        return vc
    }
    private func getItemDetailsVC() -> ServiceItemDetailsViewController {
        let id = serviceItemdetail
        let vc = Initializer.createViewController(storyBoard: .HomeSB, andId: id) as! ServiceItemDetailsViewController
      //  vc.subServiceId = serviceId
        return vc
    }
    
    private func getComplaintsVC()-> UIViewController{
        let id = complaintsId
        guard let vc = Initializer.createViewController(storyBoard: .ComplaintsSB, andId: id) as? ComplaintsListVC else {return UIViewController()}
        return vc
    }
   
}


















