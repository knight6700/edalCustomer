//
//  LookupAllModel.swift
//  EdalCustomer
//
//  Created by Mahmoud Maamoun on 22/05/2020.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit

import ObjectMapper

class LookupAllModel: Mappable {
    
    var lang: String?
    var status: String?
    var error_msg: String?
    var errors: [String:String]?
    var cities: CitiesModel?
    var terms: String?
    var ages: AgesModel?
    
       required init?(map: Map) {
           
       }

    
       // Mappable
       func mapping(map: Map) {
        lang        <- map["lang"]
        status     <- map["status"]
        error_msg   <- map["error_msg"]
        errors   <- map["errors"]
        cities   <- map["cities"]
        terms   <- map["terms"]
        ages   <- map["ages"]
    }
}
class CitiesModel: Mappable {
    
    var data: [LookupAllDataModel]?
    required init?(map: Map) {
        
    }
    // Mappable
    func mapping(map: Map) {
        data   <- map["data"]
    }
}
class AgesModel: Mappable {
    
    var data: [LookupAllDataModel]?
    required init?(map: Map) {
        
    }
    // Mappable
    func mapping(map: Map) {
        data   <- map["data"]
    }
}
