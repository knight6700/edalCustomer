//
//  GetCustomerResponse.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 11/5/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

class GetCustomerResponse: Decodable {
    let default_response: CustomerDefaultResponse
    let lang: String
    let status: String
    let error_msg: String
    let errors: [String:String]
}

class CustomerDefaultResponse: Decodable {
    let customer: Customer?
}
