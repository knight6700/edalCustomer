//
//  RegisterResponseModel.swift
//  EdalCustomer
//
//  Created by Mahmoud Maamoun on 22/05/2020.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit
import ObjectMapper

class RegisterResponseModel: Mappable {
    
    var lang: String?
    var status: String?
    var error_msg: String?
    var errors: [String:String]?
    var customer: CustomerModel?
    var errs: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        lang        <- map["lang"]
        status     <- map["status"]
        error_msg   <- map["error_msg"]
        errors   <- map["errors"]
        errs   <- map["errors"]
        customer   <- map["customer"]
        
    }
}

class CustomerModel: Mappable {
    
    var id: Int?
    var age: LookupAllDataModel?
    var api_token: String?
    var first_name: String?
    var image: String?
    var last_name: String?
    var mobile: String?
    var email: String?
    var gender: String?
    var age_id: String?
    var district_id: String?
    var location: String?
    var latitude: String?
    var longitude: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id        <- map["id"]
        age     <- map["age"]
        api_token   <- map["api_token"]
        first_name   <- map["first_name"]
        last_name   <- map["last_name"]
        mobile   <- map["mobile"]
        email   <- map["email"]
        gender   <- map["gender"]
        age_id   <- map["age_id"]
        district_id   <- map["district_id"]
        location   <- map["location"]
        latitude   <- map["latitude"]
        longitude   <- map["longitude"]
        
    }
}

