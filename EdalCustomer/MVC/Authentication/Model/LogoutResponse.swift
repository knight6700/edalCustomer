//
//  LogoutResponse.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/19/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

class  LogoutResponse: Decodable {
    let lang: String
    let status: String
    let error_msg: String
    let errors: [String: String]
}
