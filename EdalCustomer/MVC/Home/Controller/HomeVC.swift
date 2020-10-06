//
//  HomeVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/26/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITabBarDelegate {
    
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.backgroundColor = .clear
        self.tabBar.tintColor = .red
        self.tabBar.barTintColor = .white
        self.tabBar.isTranslucent = true
        
        if let items = self.tabBar.items
        {
            for item in items
            {
                if let image = item.image
                {
                    item.image = image.withRenderingMode( .alwaysOriginal )
                }
            }
        }
        // Load the first screen by default.
        performSegue(withIdentifier: "exploreSegue", sender: nil)
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue is TabBarItemSegue {
            
            // This is an example of how to use the UIViewController containment APIs.
            // If we're starting, there is not yet a child view controller added, so
            // just add it.
            if children.count == 0 {
                
                self.addChild(segue.destination)
                segue.destination.view.frame = containerView.bounds
                self.containerView.addSubview(segue.destination.view)
                segue.destination.didMove(toParent: self)
                
                // If there is already a child, swap it with the segue's destination view controller.
            } else {
                
                let oldViewController = self.children[0]
                segue.destination.view.frame = oldViewController.view.frame
                oldViewController.willMove(toParent: nil)
                self.addChild(segue.destination)
                self.transition(from: oldViewController, to: segue.destination, duration: 0, options: .transitionCrossDissolve, animations: nil) { completed in
                    oldViewController.removeFromParent()
                    segue.destination.didMove(toParent: self)
                }
            }
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.index(of: item) else { return }
        switch index {
        case 0:
            if let image = item.image
            {
                item.image = image.withRenderingMode( .alwaysOriginal )
            }
            //item.image = image.withRenderingMode( .alwaysOriginal )
            performSegue(withIdentifier: "exploreSegue", sender: nil)
        case 1:
            if let image = item.image
            {
                item.image = image.withRenderingMode( .alwaysOriginal )
            }
            performSegue(withIdentifier: "searchSegue", sender: nil)
        case 2:
            if let image = item.image
            {
                item.image = image.withRenderingMode( .alwaysOriginal )
            }
            performSegue(withIdentifier: "myEdalSegue", sender: nil)
        case 3:
            if let image = item.image
            {
                item.image = image.withRenderingMode( .alwaysOriginal )
            }
            performSegue(withIdentifier: "alertSegue", sender: nil)
        case 4:
            if let image = item.image
            {
                item.image = image.withRenderingMode( .alwaysOriginal )
            }
            performSegue(withIdentifier: "moreSegue", sender: nil)
        default:
            break
        }
    }

    

}
class TabBarItemSegue: UIStoryboardSegue {
    override func perform() {
        // Leave empty (we override prepareForSegue)
    }
}
