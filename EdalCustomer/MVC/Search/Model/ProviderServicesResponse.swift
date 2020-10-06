//
//  ProviderServicesResponse.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/30/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation


class ProviderServicesResponse: Decodable {
    
//    let lang: String
//    let status: String
//    let error_msg: String
//    let errors: [String: String]
//    let default_response : DefaultResponse
//    let providers: ServicesProviders
//   
//    let min_price: Int
//    let max_price: Int
}


//class ServicesProviders: Decodable {
//    let data: [HomeProvidersDatum]
//    let meta: ProviderServicesMeta
//}
class ProviderServicesMeta: Decodable {
    let pagination: ProviderServicesPagination
    
}
class ProviderServicesPagination: Decodable {
    let total: Int
    let count: Int
    let per_page: Int
    let current_page: Int
    let total_pages: Int
}




