//
//  VerifyCodeResponse.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/6/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation


class VerifyCodeResponse: Decodable {
    let lang: String
    let status: String
    let error_msg: String
    let errors : [String: String]
    let code: Int? // for sending and resending verification code only
}
