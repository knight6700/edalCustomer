//
//  ResendCode.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/7/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

class ResendCode: Decodable {
    let lang: String
    let status: String
    let code: Int
    let default_response: String?
    let error_msg: String
    let errors: [String: String]
}
