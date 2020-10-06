//
//  UIFontExtension.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/25/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

extension UIFont{
    class func SFRegular(size: CGFloat) -> UIFont{
        guard let font = UIFont(name: "SFUIDisplay-Regular", size: size) else{
            return UIFont()
        }
        return font
    }
    
    class func SFLight(size: CGFloat) -> UIFont{
        guard let font = UIFont(name: "SFUIDisplay-Light", size: size) else{
            return UIFont()
        }
        return font
    }
    
    class func SFThin(size: CGFloat) -> UIFont{
        guard let font = UIFont(name: "SFUIDisplay-Thin", size: size) else{
            return UIFont()
        }
        return font
    }
    
    class func SFMedium(size: CGFloat) -> UIFont{
        guard let font = UIFont(name: "SFUIDisplay-Medium", size: size) else{
            return UIFont()
        }
        return font
    }
    
    class func SFBold(size: CGFloat) -> UIFont{
        guard let font = UIFont(name: "SFUIDisplay-Bold", size: size) else{
            return UIFont()
        }
        return font
    }
    
    class func SFBlack(size: CGFloat) -> UIFont{
        guard let font = UIFont(name: "SFUIDisplay-Black", size: size) else{
            return UIFont()
        }
        return font
    }
    
    class func SFSemibold(size: CGFloat) -> UIFont{
        guard let font = UIFont(name: "SFUIDisplay-Semibold", size: size) else{
            return UIFont()
        }
        return font
    }
    
    class func SFHeavy(size: CGFloat) -> UIFont{
        guard let font = UIFont(name: "SFUIDisplay-Heavy", size: size) else{
            return UIFont()
        }
        return font
    }
    
    class func SFUltralight(size: CGFloat) -> UIFont{
        guard let font = UIFont(name: "SFUIDisplay-Ultralight", size: size) else{
            return UIFont()
        }
        return font
    }
}


