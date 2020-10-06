//
//  LookupAllDataModel.swift
//  EdalCustomer
//
//  Created by Mahmoud Maamoun on 22/05/2020.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit
import ObjectMapper
class LookupAllDataModel: Mappable {
    var id: Int? = 0          // for all
    var title: String?  = ""  // for business_sizes, years_of_experience, districts
    var name: String?   = ""  // for categories, cities, subCategories
    var icon: String?   = ""  // for categories
    
    required init?(map: Map) {
        
    }
    // Mappable
    func mapping(map: Map) {
        id        <- map["id"]
        title        <- map["title"]
        name        <- map["name"]
        icon        <- map["icon"]
        
    }
}
