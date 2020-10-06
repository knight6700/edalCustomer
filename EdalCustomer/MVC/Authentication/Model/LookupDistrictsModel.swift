//
//  LookupDistrictsModel.swift
//  Edal_Provider_iOS
//
//  Created by Mahmoud Maamoun on 15/05/2020.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit
import ObjectMapper

class LookupDistrictsModel: Mappable {
    
    var lang: String?
    var status: String?
    var error_msg: String?
    var errors: [String:String]?
    var districts: DistrictsModel?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        lang        <- map["lang"]
        status     <- map["status"]
        error_msg   <- map["error_msg"]
        errors   <- map["errors"]
        districts   <- map["districts"]
        
    }
}
class DistrictsModel: Mappable {
    
     var data: [LookupAllDataModel]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        data   <- map["data"]
        
    }
}

