//
//  AuthNavigator.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/25/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//


import UIKit

class AuthNavigator: Navigator {
    
    // MARK: viewControllers id
    private let OnBoardId = "OnBoardVC"
    private let authenticationId = "AuthenticationVC"
    private let loginId = "LoginVC"
    private let registrationId = "RegistrationVC"
    private let passwordId = "PasswordVC"
    private let termsAndConditionsId = "TermsAndConditionsVC"
    private let verificationId = "VerificationVC"
    private let thankYouId = "ThankYouVC"
    private let passwordResetSuccessedId = "PasswordResetSuccessedVC"
    private let sorryPopUpId = "SorryPopUpVC"
    private let newPasswordId = "NewPasswordVC"
    private let profileId = "ProfileVC"
    private let homeId = "HomeVC"
    
    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
        case onBoard
        case authentication
        case login
        case registration(firstName: String?, lastName: String?, email: String?)
        case password
        case termsAndConditions(cameFrom: CameToTermsAndConditionsFrom)
        case verification(cameFrom: CameToVerificationFrom)
        case thankYou
        case passwordResetSuccessed
        case sorryPopUp
        case newPassword
        case profile
        case home
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
        case .onBoard:
            return getOnBoardVC()
        case .authentication:
            return getAuthenticationVC()
        case .login:
            return getLoginVC()
        case .registration(let first,let last, let email):
            return getRegistrationVC(firstName: first, lastName: last, email: email)
        case .password:
            return getPasswordVC()
        case .termsAndConditions(let from):
            return getTermsAndConditionsVC(from: from)
        case .verification(let from):
            return getVerificationVC(from: from)
        case .passwordResetSuccessed:
            return getPasswordResetSuccessedVC()
        case .sorryPopUp:
            return getSorryPopUpVC()
        case .newPassword:
            return getNewPasswordVC()
        case .thankYou:
            return getThankYouVC()
            
        case .profile:
            return getProfileVC()
        case .home:
            return getHomeVC()
        }
    }
    private func getOnBoardVC() -> UIViewController{
        let id = OnBoardId
        let vc = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! OnBoardVC
        return vc
    }
    private func getAuthenticationVC() -> UIViewController{
        let id = authenticationId
        let vc = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! AuthenticationVC

        return vc
    }
    
    private func getLoginVC() -> UIViewController{
        let id = loginId
        let vc = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! LoginVC
        
        return vc
    }
    
    private func getRegistrationVC(firstName: String?, lastName: String?, email: String?) -> UIViewController{
        let id = registrationId
        let vc = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! RegistrationVC
        vc.email = email
        vc.firstName = firstName
        vc.lastName = lastName
        return vc
    }
    
    private func getPasswordVC() -> UIViewController{
        let id = passwordId
        let vc = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! PasswordVC
        return vc
    }
    
    private func getTermsAndConditionsVC(from: CameToTermsAndConditionsFrom) -> UIViewController{
        let id = termsAndConditionsId
        let vc = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! TermsAndConditionsVC
        vc.cameFrom = from
        return vc
    }
    private func getVerificationVC(from: CameToVerificationFrom) -> UIViewController{
        let id = verificationId
        let vc = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! VerificationVC
        vc.cameFrom = from
        return vc
    }
    
    private func getPasswordResetSuccessedVC() -> UIViewController{
        let id = passwordResetSuccessedId
        let vc = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! PasswordResetSuccessedVC
        return vc
    }
    private func getSorryPopUpVC() -> UIViewController{
        let id = sorryPopUpId
        let vc = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! SorryPopUpVC
        return vc
    }
    
    private func getThankYouVC() -> UIViewController{
        let id = thankYouId
        let vc = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! ThankYouVC
        return vc
    }
    private func getNewPasswordVC() -> UIViewController{
        let id = newPasswordId
        let vc = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! NewPasswordVC
        return vc
    }
    
    private func getProfileVC() -> UIViewController{
        let id = profileId
        let vc = Initializer.createViewController(storyBoard: .ProfileSB, andId: id) as! ProfileVC
        return vc
    }
    
    private func getHomeVC() -> UIViewController{
        let id = homeId
        let vc = Initializer.createViewController(storyBoard: .HomeSB, andId: id) as! HomeVC
        return vc
    }


}


















