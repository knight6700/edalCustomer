//
//  BusinessProfileDetailsResponse.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/8/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

//import Foundation

//class BusinessProfileDetailsResponse: Decodable {
//    let lang: String
//    let status: String
//    let error_msg: String
//    let errors: [String: String]
//    let default_response : DefaultResponse
//    let providers: ProviderUserModel
//    
//}
//class ProfileDetailsResponse: Codable {
//    let id: Int
//    let isMain: Bool
//    let businessName, firstName, lastName, email: String
//    let mobile: String
//    let image, bgImage: String
//    let phone: String
//    let yearID, businessSizeID, districtID: Int
//    let address, latitude, longitude, about: String
//    let websiteLink, facebookLink, twitterLink, instagramLink: String?
//    let active, visible: Int
//    let favorite: Bool
//    let subCategoryName, categoryName: String
//    let imagesCount, rate, raters, minValue: Int
//    let maxValue: Int
//    let year, businessSize, district: BusinessSize
//    let city, subCategory: City
//    let mainCategory: MainCategory
//    let resources: Resources
//    let workingDays: WorkingDays
//    let images: ImagesProvider
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case isMain = "is_main"
//        case businessName = "business_name"
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case email, mobile, image
//        case bgImage = "bg_image"
//        case phone
//        case yearID = "year_id"
//        case businessSizeID = "business_size_id"
//        case districtID = "district_id"
//        case address, latitude, longitude, about
//        case websiteLink = "website_link"
//        case facebookLink = "facebook_link"
//        case twitterLink = "twitter_link"
//        case instagramLink = "instagram_link"
//        case active, visible, favorite
//        case subCategoryName = "sub_category_name"
//        case categoryName = "category_name"
//        case imagesCount = "images_count"
//        case rate, raters
//        case minValue = "min_value"
//        case maxValue = "max_value"
//        case year
//        case businessSize = "business_size"
//        case district, city
//        case subCategory = "sub_category"
//        case mainCategory = "main_category"
//        case resources
//        case workingDays = "working_days"
//        case images
//    }
//}

//class BusinessSize: Codable {
//    let id: Int
//    let title: String
//}
//
//class City: Codable {
//    let id: Int
//    let name: String
//}

class ImagesProvider: Codable {
    let data: [ImagesProviderData]
}

class ImagesProviderData: Codable {
    let id, providerID: Int
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case providerID = "provider_id"
        case image
    }
}
//
//class MainCategory: Codable {
//    let id: Int
//    let name: String
//    let icon: String
//}

//class Resources: Codable {
//    let data: [ResourcesDatum]
//}

//class ResourcesDatum: Codable {
//    let id: Int
//    let name, position: String
//    let image: String
//    let bio: String
//    let gender, status: Int
//}

//class WorkingDays: Codable {
//    let data: [WorkingDaysDatum]
//}
//
//class WorkingDaysDatum: Codable {
//    let id, day: Int
//    let from, to: String
//    let breaks: Breaks
//}

//class Breaks: Codable {
//    let data: [BreaksDatum]
//}
//
//class BreaksDatum: Codable {
//    let id: Int
//    let from, to: String
//}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


