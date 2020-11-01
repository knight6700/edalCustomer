//
//  ServicesProvidersModel.swift
//  EdalCustomer
//
//  Created by Mahmoud Maamoun on 22/05/2020.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit
import ObjectMapper
class ServicesProvidersModel: Mappable {
    
    
    var data: [HomeProvidersDatum]?
    var meta : Meta?
      
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
        meta <- map["meta"]
        
    }
    
      
}
