//
//  ProviderNavigator.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/26/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
class ProfileNavigator: Navigator {
    // MARK: viewControllers id
    private let categoriesId = "CagetoriesVC"
    private let homeId = "HomeVC"
    private let profileId = "HomeVC"
    private let mapId = "MapVC"
    private let personalInfoId = "PersonalInfoVC"
    private let editPersonalInfoId = "EditPersonalInfoVC"
    private let editLocationId = "EditLocationVC"
    private let updatePasswordId = "UpdatePasswordVC"
    private let updatedPasswordId = "UpdatedPasswordVC"
    
    
   // private let changeLocationId = "ChangeLocationVC"
    
    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
        case home
        case categories
        case profile
        case personalInfo
        case editPersonalInfo
        case editLocation
        case updatePassword
        case updatedPassword

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
        case .home:
            return homeVC()
        case .categories:
            return categoriesVC()
        case .profile:
            return profileVC()
        case .personalInfo:
            return personalInfoVC()
        case .editPersonalInfo:
            return editPersonalInfoVC()
        case .editLocation:
            return editLocationVC()
        case .updatePassword:
            return updatePasswordVC()
        case .updatedPassword:
            return updatedPasswordVC()
        }
    }
    
    private func homeVC() -> UIViewController{
        let id = homeId
        let nextVC = Initializer.createViewController(storyBoard: .HomeSB , andId: id) as! HomeTabBarController
        return nextVC
    }
    
    private func categoriesVC() -> UIViewController{
        let id = categoriesId
        let nextVC = Initializer.createViewController(storyBoard: .CategoriesSB , andId: id) as! CategoriesVC
        return nextVC
    }
    private func profileVC() -> UIViewController{
        let id = profileId
        let nextVC = Initializer.createViewController(storyBoard: .ProfileSB , andId: id) as! ProfileVC
        return nextVC
    }
    private func personalInfoVC() -> UIViewController{
        let id = personalInfoId
        let nextVC = Initializer.createViewController(storyBoard: .ProfileSB , andId: id) as! PersonalInfoVC
        return nextVC
    }
    private func editPersonalInfoVC() -> UIViewController{
        let id = editPersonalInfoId
        let nextVC = Initializer.createViewController(storyBoard: .ProfileSB , andId: id) as! EditPersonalInfoVC
        return nextVC
    }
    private func editLocationVC() -> UIViewController{
        let id = editLocationId
        let nextVC = Initializer.createViewController(storyBoard: .ProfileSB , andId: id) as! EditLocationVC
        return nextVC
    }
    private func updatePasswordVC() -> UIViewController{
        let id = updatePasswordId
        let nextVC = Initializer.createViewController(storyBoard: .ProfileSB , andId: id) as! UpdatePasswordVC
        return nextVC
    }
    
    private func updatedPasswordVC() -> UIViewController{
        let id = updatedPasswordId
        let nextVC = Initializer.createViewController(storyBoard: .ProfileSB , andId: id) as! UpdatedPasswordVC
        return nextVC
    }
    

    
}


