//
//  SingletonClass.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/21/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

class SingletonClass:NSObject
{
    static let shared = SingletonClass()
    var searchNav = UINavigationController()
}
