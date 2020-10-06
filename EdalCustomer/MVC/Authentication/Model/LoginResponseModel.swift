//
//  LoginResponseModel.swift
//  EdalCustomer
//
//  Created by Mahmoud Maamoun on 22/05/2020.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit
import ObjectMapper
class LoginResponseModel: Mappable {
    var lang: String?
    var status: String?
    var error_msg: String?
    var errors: [String:String]?
    var first_login: Int?
    var customer: CustomerModel?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        lang        <- map["lang"]
        status     <- map["status"]
        error_msg   <- map["error_msg"]
        errors   <- map["errors"]
        first_login   <- map["first_login"]
        customer   <- map["customer"]
        
    }
}
