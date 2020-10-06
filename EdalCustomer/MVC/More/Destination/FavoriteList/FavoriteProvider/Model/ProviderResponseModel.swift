//
//  ProviderResponseModel.swift
//  EdalCustomer
//
//  Created by Mahmoud Maamoun on 22/05/2020.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit
import ObjectMapper

class ProviderResponseModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        providers <- map["providers"]
    }
    
    var providers: ServicesProvidersModel? = nil
    
}
