//
//  ServicesSubCategories.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/30/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

class ServicesSubCategoriesResponse: Decodable {
    let lang, status, error_msg: String
    let errors: [String: String]
   // let default_response: DefaultResponse?
    let services: ServicesSubCategories
}

class  ServicesSubCategories: Decodable {
    let data: [ServicesSubCategoriesData]
}

class ServicesSubCategoriesData: Decodable {
    let id: Int
    let name: String
    let icon: String
    let min_value: Int?
    let max_value: Int?
}
