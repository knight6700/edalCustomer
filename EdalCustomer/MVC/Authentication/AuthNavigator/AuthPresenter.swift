import Foundation
import UIKit

class AuthPresenter{
    
    // MARK: viewControllers id
    
    private let LookUpPopUpId = "LookUpPopUpVC"
    private let forgotPasswordId = "ForgotPasswordVC"
    //private let setPasswordId = "PasswordVC"
    
    // Here we define a set of supported destinations using an
    // enum, and we can also use associated values to add support
    // for passing arguments from one screen to another.
    enum Destination {
        case searchLookUpPopUp(type: LookUpPopUpType, searchlookUpPopup: Categories )
        case lookUpPopUp(type: LookUpPopUpType, lookUpAll: LookupAllModel?, lookUpDistricts: LookupDistrictsModel?)
        case forgotPassword
        //        case AgePopUp(let age)
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
        case .forgotPassword:
            presentForgotPassword()
        case .lookUpPopUp(let type, let lookUpAll, let lookUpDistricts):
            presentLookUpPopUp(type: type, lookUpAll: lookUpAll, lookUpDistricts: lookUpDistricts)
        case .searchLookUpPopUp(let type, let searchlookPopup):
            presentSearchLookUpPopUp(type: type, searchLookupPopup: searchlookPopup)
            
        }
    }
    
    private func presentLookUpPopUp(type: LookUpPopUpType, lookUpAll: LookupAllModel?, lookUpDistricts: LookupDistrictsModel?){
        let id = LookUpPopUpId
        let nextVC = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! LooksUpPopUpVC
        nextVC.lookUpPopUpType = type
        nextVC.lookUpAll = lookUpAll
        nextVC.lookUpDistricts = lookUpDistricts
        nextVC.LookUpPopUpDelegate = viewController as? LookUpPopUpDataSource
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.modalTransitionStyle = .crossDissolve
        viewController?.present(nextVC, animated: true, completion: nil)
    }
    
    private func presentSearchLookUpPopUp(type: LookUpPopUpType, searchLookupPopup: Categories?){
        let id = LookUpPopUpId
        let nextVC = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! LooksUpPopUpVC
        nextVC.lookUpPopUpType = type
        nextVC.searchCategoriesLookup = searchLookupPopup
        nextVC.searchLookupDelegate = viewController as? SearchLookUpDataSource
        nextVC.modalPresentationStyle = .overFullScreen
        nextVC.modalTransitionStyle = .crossDissolve
//        UIApplication.shared.keyWindow?.addSubview(nextVC.view)
//        UIApplication.shared.keyWindow?.bringSubview(toFront: nextVC.view)
        viewController?.present(nextVC, animated: true, completion: nil)
    }
    
    private func presentForgotPassword(){
        let id = forgotPasswordId
        let nextVC = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! ForgetPasswordVC
        let nextVCWithNav = UINavigationController(rootViewController: nextVC)
        viewController?.present(nextVCWithNav, animated: true, completion: nil)
    }
    
    
    //Age Pop Up
    private func presentAgePopUp(){
        let id = LookUpPopUpId
        let nextVC = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! LooksUpPopUpVC
        //nextVC.Age = Age
        let nextVCWithNav = UINavigationController(rootViewController: nextVC)
        viewController?.present(nextVCWithNav, animated: true, completion: nil)
    }
    
}






