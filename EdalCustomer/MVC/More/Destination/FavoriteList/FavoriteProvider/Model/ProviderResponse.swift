//
//  ProviderResponse.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/15/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

/// you will found Provider response, when u search 4 FavoriteProvider
struct FavoriteListModel: Codable {
    var lang, status, errorMsg: String?
    var errors: Errors?
    var defaultResponse: DefaultResponseFavorite?

    enum CodingKeys: String, CodingKey {
        case lang, status
        case errorMsg = "error_msg"
        case errors
        case defaultResponse = "default_response"
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDefaultResponse { response in
//     if let defaultResponse = response.result.value {
//       ...
//     }
//   }

// MARK: - DefaultResponse
struct DefaultResponseFavorite: Codable {
    var providers: ProvidersFavorite?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseProviders { response in
//     if let providers = response.result.value {
//       ...
//     }
//   }

// MARK: - Providers
struct ProvidersFavorite: Codable {
    var data: [ProvidersDatumProvidersFavorite]?
    var meta: MetaFavorite?
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
struct ProvidersDatumProvidersFavorite: Codable {
    var id: Int?
    var isMain: Bool?
    var businessName, firstName, lastName, email: String?
    var mobile: String?
    var image: String?
    var bgImage: String?
    var phone: String?
    var yearID, businessSizeID, districtID: Int?
    var address: String?
    var latitude, longitude, about: String?
    var websiteLink, facebookLink, twitterLink, instagramLink: String?
    var active, visible: Int?
    var favorite: Bool?
    var subCategoryName: SubCategoryName?
    var categoryName: Name?
    var imagesCount, rate, raters, minValue: Int?
    var maxValue: Int?
    var year, businessSize, district: BusinessSizeFavorite?
    var city, subCategory: CityCity?
    var mainCategory: MainCategoryFavorite?
    var images: ImagesFavorite?

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
struct BusinessSizeFavorite: Codable {
    var id: Int?
    var title: String?
}

enum Name: String, Codable {
    case food = "Food"
    case healthBeauty = "Health & Beauty"
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
struct CityCity: Codable {
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
struct ImagesFavorite: Codable {
    var data: [ImagesDatumFavorite]?
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
struct ImagesDatumFavorite: Codable {
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
struct MainCategoryFavorite: Codable {
    var id: Int?
    var name: Name?
    var icon: String?
}

enum SubCategoryName: String, Codable {
    case gymCenters = "Gym Centers"
    case makeUp = "Make-Up"
    case subCat2 = "Sub Cat 2"
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
struct MetaFavorite: Codable {
    var pagination: PaginationFavorite?
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
struct PaginationFavorite: Codable {
    var total, count, perPage, currentPage: Int?
    var totalPages: Int?
    var links: Links?

    enum CodingKeys: String, CodingKey {
        case total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case links
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseLinks { response in
//     if let links = response.result.value {
//       ...
//     }
//   }

// MARK: - Links
struct Links: Codable {
    var next: String?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseErrors { response in
//     if let errors = response.result.value {
//       ...
//     }
//   }
