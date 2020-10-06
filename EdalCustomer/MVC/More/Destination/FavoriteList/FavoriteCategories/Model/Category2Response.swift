////
////  Category2Response.swift
////  edal-IosCustomerApp
////
////  Created by Medhat ali on 9/10/19.
////  Copyright © 2019 hesham ghalaab. All rights reserved.
////
//
//import Foundation
//
//
//class CategoryResponse: Decodable {
//    let lang: String?
//    let status: String?
//    let error_msg: String?
//    let errors: Errors2?
//    let defaultResponse: [Any]?
//    let categories: Categories?
//    let paginated_categories: PaginatedCategories?
//    
//    private enum CodingKeys: String, CodingKey {
//        case lang = "lang"
//        case status = "status"
//        case error_msg = "error_msg"
//        case errors = "errors"
//        case defaultResponse = "default_response"
//        case categories = "categories"
//        case paginated_categories = "paginated_categories"
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        lang = try values.decodeIfPresent(String.self, forKey: .lang)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        error_msg = try values.decodeIfPresent(String.self, forKey: .error_msg)
//        errors = try values.decodeIfPresent(Errors2.self, forKey: .errors)
//        defaultResponse = [] // TODO: Add code for decoding `defaultResponse`, It was empty at the time of model creation.
//        categories = try values.decodeIfPresent(Categories.self, forKey: .categories)
//        paginated_categories = try values.decodeIfPresent(PaginatedCategories.self, forKey: .paginated_categories)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(lang, forKey: .lang)
//        try container.encodeIfPresent(status, forKey: .status)
//        try container.encodeIfPresent(error_msg, forKey: .error_msg)
//        try container.encodeIfPresent(errors, forKey: .errors)
//        // TODO: Add code for encoding `defaultResponse`, It was empty at the time of model creation.
//        try container.encodeIfPresent(categories, forKey: .categories)
//        try container.encodeIfPresent(paginated_categories, forKey: .paginated_categories)
//    }
//}
//
//class Errors2: Codable {
//
//}
//
//class Categories: Codable {
//    
//    let data: [CategoriesData]?
//    
//    private enum CodingKeys: String, CodingKey {
//        case data = "data"
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        data = try values.decodeIfPresent([CategoriesData].self, forKey: .data)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(data, forKey: .data)
//    }
//    
//}
//
//
//class CategoriesData: Codable {
//    
//    let id: Int?
//    let name: String?
//    let icon: String?
//    
//    private enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case icon = "icon"
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        icon = try values.decodeIfPresent(String.self, forKey: .icon)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(id, forKey: .id)
//        try container.encodeIfPresent(name, forKey: .name)
//        try container.encodeIfPresent(icon, forKey: .icon)
//}
//
//}
//
//
//class PaginatedCategories: Codable {
//    
//    let data: [CategoriesData]?
//    let meta: Meta2?
//    
//    private enum CodingKeys: String, CodingKey {
//        case data = "data"
//        case meta = "meta"
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        data = try values.decodeIfPresent([CategoriesData].self, forKey: .data)
//        meta = try values.decodeIfPresent(Meta2.self, forKey: .meta)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(data, forKey: .data)
//        try container.encodeIfPresent(meta, forKey: .meta)
//    }
//    
//}
//
//
//class Meta2: Codable {
//    
//    let pagination: Pagination2?
//    
//    private enum CodingKeys: String, CodingKey {
//        case pagination = "pagination"
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        pagination = try values.decodeIfPresent(Pagination2.self, forKey: .pagination)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(pagination, forKey: .pagination)
//    }
//    
//}
//
//class Pagination2: Codable {
//    
//    let total: Int?
//    let count: Int?
//    let per_Page: Int?
//    let current_Page: Int?
//    let total_pages: Int?
//    let links: Links2?
//    
//    private enum CodingKeys: String, CodingKey {
//        case total = "total"
//        case count = "count"
//        case perPage = "per_page"
//        case currentPage = "current_page"
//        case totalPages = "total_pages"
//        case links = "links"
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        total = try values.decodeIfPresent(Int.self, forKey: .total)
//        count = try values.decodeIfPresent(Int.self, forKey: .count)
//        per_Page = try values.decodeIfPresent(Int.self, forKey: .perPage)
//        current_Page = try values.decodeIfPresent(Int.self, forKey: .currentPage)
//        total_pages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
//        links = try values.decodeIfPresent(Links2.self, forKey: .links)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(total, forKey: .total)
//        try container.encodeIfPresent(count, forKey: .count)
//        try container.encodeIfPresent(per_Page, forKey: .perPage)
//        try container.encodeIfPresent(current_Page, forKey: .currentPage)
//        try container.encodeIfPresent(total_pages, forKey: .totalPages)
//        try container.encodeIfPresent(links, forKey: .links)
//    }
//    
//}
//
//
//class Links2: Codable {
//    
//}
//
