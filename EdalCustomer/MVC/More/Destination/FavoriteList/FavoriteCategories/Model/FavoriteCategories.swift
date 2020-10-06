//
//  FavoriteCategories.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/28/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

class FavoriteCategories: Decodable {
    let lang, status, error_msg: String
    let errors: [String: String]
}
