//
//  CategoryResponseModel.swift
//  EdalCustomer
//
//  Created by Mahmoud Maamoun on 13/06/2020.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit
import ObjectMapper

class CategoryResponseModel: Mappable {
    
    var lang: String?
    var status: String?
    var error_msg: String?
    var errors: [String:String]?
    var code: Int?  // for sending and resending verification code only
    var defaultResponse: [Any]?
    var categories: Categories?
    var paginated_categories: PaginatedCategories?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        lang        <- map["lang"]
        status     <- map["status"]
        error_msg   <- map["error_msg"]
        errors   <- map["errors"]
        code   <- map["code"]
        
        defaultResponse   <- map["defaultResponse"]
        categories   <- map["categories"]
        paginated_categories   <- map["paginated_categories"]
        
    }
}

class Categories: Mappable {
    
    var data: [CategoriesData]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        data        <- map["data"]
    }
}

class CategoriesData: Mappable {
    
    var id: Int?
    var name: String?
    var icon: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id        <- map["id"]
        name        <- map["name"]
        icon        <- map["icon"]
    }
}
class PaginatedCategories: Mappable {
    
    var id: Int?
    var data: [CategoriesData]?
    var meta: Meta2?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id        <- map["id"]
        data        <- map["data"]
        meta        <- map["meta"]
    }
}
class Meta2: Mappable {
    
    var pagination: Pagination2?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        pagination        <- map["pagination"]
        
    }
}
class Pagination2: Mappable {
    
    var total: Int?
    var count: Int?
    var per_Page: Int?
    var current_Page: Int?
    var total_pages: Int?
//    var links: Links2?
    
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        total        <- map["total"]
        count        <- map["count"]
        per_Page        <- map["per_Page"]
        current_Page        <- map["current_Page"]
        total_pages        <- map["total_pages"]
//        links        <- map["links"]
        
    }
}

