//
//  Navigator.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/25/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

protocol Navigator {
    associatedtype Destination
    func navigate(to destination: Destination)
}
