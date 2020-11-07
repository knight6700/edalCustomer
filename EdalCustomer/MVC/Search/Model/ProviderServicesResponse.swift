//
//  ProviderServicesResponse.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/30/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

struct SearchableResponse: Codable {
    var lang, status, errorMsg: String?
    var errors: Errors?
    var defaultResponse: [String]?
    var providers: Providers?
    var minPrice, maxPrice: Int?

    enum CodingKeys: String, CodingKey {
        case lang, status
        case errorMsg = "error_msg"
        case errors
        case defaultResponse = "default_response"
        case providers
        case minPrice = "min_price"
        case maxPrice = "max_price"
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseErrors { response in
//     if let errors = response.result.value {
//       ...
//     }
//   }

// MARK: - Errors

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseProviders { response in
//     if let providers = response.result.value {
//       ...
//     }
//   }

// MARK: - Providers
struct Providers: Codable {
    var data: [ProvidersDatum]?
    var meta: Metas?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseProvidersDatum { response in
//     if let providersDatum = response.result.value {
//       ...
//     }
//   }

// MARK: - ProvidersDatum
struct ProvidersDatum: Codable {
    var id: Int?
    var isMain: Bool?
    var businessName, firstName, lastName, email: String?
    var mobile: String?
    var image, bgImage: String?
    var phone: String?
    var yearID, businessSizeID, districtID: Int?
    var address, latitude, longitude: String?
    var about: String?
    var websiteLink, facebookLink, twitterLink, instagramLink: String?
    var active, visible: Int?
    var favorite: Bool?
    var subCategoryName, categoryName: String?
    var imagesCount, rate, raters, minValue: Int?
    var maxValue: Int?
    var year, businessSize, district: BusinessSizes?
    var city, subCategory: Citiess?
    var mainCategory: MainCategories?
    var images: Images?
    var distance: Double?
    enum CodingKeys: String, CodingKey {
        case id
        case isMain = "is_main"
        case businessName = "business_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case email, mobile, image
        case bgImage = "bg_image"
        case phone
        case yearID = "year_id"
        case businessSizeID = "business_size_id"
        case districtID = "district_id"
        case address, latitude, longitude, about
        case websiteLink = "website_link"
        case facebookLink = "facebook_link"
        case twitterLink = "twitter_link"
        case instagramLink = "instagram_link"
        case active, visible, favorite
        case subCategoryName = "sub_category_name"
        case categoryName = "category_name"
        case imagesCount = "images_count"
        case rate, raters
        case minValue = "min_value"
        case maxValue = "max_value"
        case year
        case businessSize = "business_size"
        case district, city
        case subCategory = "sub_category"
        case mainCategory = "main_category"
        case images
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseBusinessSize { response in
//     if let businessSize = response.result.value {
//       ...
//     }
//   }

// MARK: - BusinessSize
struct BusinessSizes: Codable {
    var id: Int?
    var title: String?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCity { response in
//     if let city = response.result.value {
//       ...
//     }
//   }

// MARK: - City
struct Citiess: Codable {
    var id: Int?
    var name: String?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseImages { response in
//     if let images = response.result.value {
//       ...
//     }
//   }

// MARK: - Images
struct Images: Codable {
    var data: [ImagesDatum]?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseImagesDatum { response in
//     if let imagesDatum = response.result.value {
//       ...
//     }
//   }

// MARK: - ImagesDatum
struct ImagesDatum: Codable {
    var id, providerID: Int?
    var image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case providerID = "provider_id"
        case image
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseMainCategory { response in
//     if let mainCategory = response.result.value {
//       ...
//     }
//   }

// MARK: - MainCategory
struct MainCategories: Codable {
    var id: Int?
    var name: String?
    var icon: String?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseMeta { response in
//     if let meta = response.result.value {
//       ...
//     }
//   }

// MARK: - Meta
struct Metas: Codable {
    var pagination: Paginations?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responsePagination { response in
//     if let pagination = response.result.value {
//       ...
//     }
//   }

// MARK: - Pagination
struct Paginations: Codable {
    var total, count, perPage, currentPage: Int?
    var totalPages: Int?
    var links: Errors?

    enum CodingKeys: String, CodingKey {
        case total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case links
    }
}

// MARK: - Helper functions for creating encoders and decoders

