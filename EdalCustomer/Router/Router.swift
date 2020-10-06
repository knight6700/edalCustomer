//
//  Router.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/23/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

class Router {
    
    private func go(withVC vc: UIViewController){
        let window = Initializer.getWindow()
        window.makeKeyAndVisible()
        window.rootViewController = vc
    }
    private func goWithTabBarController(withVC tabBarVC: UITabBarController){
        let window = Initializer.getWindow()
        window.makeKeyAndVisible()
        window.rootViewController = tabBarVC
    }
    
    private func go(withNavigationVC vc: UINavigationController){
        let window = Initializer.getWindow()
        window.makeKeyAndVisible()
        window.rootViewController = vc
    }
    
    func toOnBoardingVC(){
        let id = "OnBoardVC"
        let nextVC = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! OnBoardVC
        let nextVcInNavigation = UINavigationController(rootViewController: nextVC)
        go(withNavigationVC:  nextVcInNavigation)
    }
    
    func toAuthenticationVC(){
        let id = "AuthenticationVC"
        let nextVC = Initializer.createViewController(storyBoard: .AuthenticationSB, andId: id) as! AuthenticationVC
        let nextVcInNavigation = UINavigationController(rootViewController: nextVC)
        go(withNavigationVC: nextVcInNavigation)
    }
    
    func toCategoriesVC() {
        let id = "CagetoriesVC"
        let nextVC = Initializer.createViewController(storyBoard: .CategoriesSB , andId: id) as! CategoriesVC
        let nextVcInNavigation = UINavigationController(rootViewController: nextVC)
        go(withNavigationVC: nextVcInNavigation)
    }
    
    func toProviderServicesVC(){
        let id = "ProviderServicesVC"
        let nextVC = Initializer.createViewController(storyBoard: .SearchSB, andId: id) as! ProviderServicesVC
        let nextVcInNavigation = UINavigationController(rootViewController: nextVC)
        go(withNavigationVC: nextVcInNavigation)
    }
    
    func toHomeTabBarVC(){
        let id = "HomeVC"
        let nextVC = Initializer.createViewController(storyBoard: .HomeSB, andId: id) as! HomeTabBarController
        goWithTabBarController(withVC: nextVC)
    }
    func toSplach(){
        let id = "LaunchScreen"
        let nextVC = Initializer.createViewController(storyBoard: .LaunchScreen, andId: id)
        go(withVC : nextVC)
    }
    
}
