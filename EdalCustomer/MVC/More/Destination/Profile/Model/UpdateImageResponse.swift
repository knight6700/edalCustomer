//
//  UpdatePhotoResponse.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/21/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation


class UpdateImageResponse: Decodable {
    let lang, status, errorMsg: String
    let errors: [String:String]
    let defaultResponse: [DefaultResponse]?
    let customer: Customer?
    
    enum CodingKeys: String, CodingKey {
        case lang, status
        case errorMsg = "error_msg"
        case errors
        case defaultResponse = "default_response"
        case customer
    }
}
