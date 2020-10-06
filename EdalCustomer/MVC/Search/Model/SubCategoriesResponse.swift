//
//  SubCategories.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/30/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

class SubCategoriesResponse: Decodable {
    let lang, status, error_msg: String
    let errors: [String: String]
    //let default_response: DefaultResponse?
    let sub_categories: SubCategories
}

class  SubCategories: Decodable {
    let data: [SubCategoriesData]
}

class SubCategoriesData: Decodable {
    let id: Int
    let name: String
}
