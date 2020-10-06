//
//  Initializer.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/25/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class Initializer {
    
    class func getStoryBoard(WithName name: StoryBoard)-> UIStoryboard {
        let storyBoard = UIStoryboard(name: name.rawValue, bundle: nil)
        return storyBoard
    }
    
//    class func getWindow()->UIWindow{
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let window = appDelegate.window
//        return window!
//    }
    class func getWindow() -> UIWindow {
             if #available(iOS 13.0, *) {
                 let appDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                 let window = appDelegate.window
                 return window!
             } else {
                 // Fallback on earlier versions
                 let appDelegate = UIApplication.shared.delegate as! AppDelegate
                 let window = appDelegate.window
                 return window!
             }
          
         }
    class func createViewController(storyBoard: StoryBoard ,andId id: String)->UIViewController{
        let storboard = getStoryBoard(WithName: storyBoard)
        let vc = storboard.instantiateViewController(withIdentifier: id)
        return vc
    }
    
}
