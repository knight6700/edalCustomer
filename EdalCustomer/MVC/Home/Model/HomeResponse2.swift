//
//  HomeResponse2.swift
//  edal-IosCustomerApp
//
//  Created by Medhat ali on 9/10/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//
/*
import Foundation

class HomeResponse: Codable {

    let lang: String?
    let status: String?
    let errorMsg: String?
    let errors: Errors?
    let defaultResponse: [Any]?
    let homeProviders: Providers?
    let recentServices: RecentServices?
    let recommendedProviders: Providers?
    
    private enum CodingKeys: String, CodingKey {
        case lang = "lang"
        case status = "status"
        case errorMsg = "error_msg"
        case errors = "errors"
        case defaultResponse = "default_response"
        case homeProviders = "home_providers"
        case recentServices = "recent_services"
        case recommendedProviders = "recommended_providers"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lang = try values.decodeIfPresent(String.self, forKey: .lang)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        errorMsg = try values.decodeIfPresent(String.self, forKey: .errorMsg)
        errors = try values.decodeIfPresent(Errors.self, forKey: .errors)
        defaultResponse = [] // TODO: Add code for decoding `defaultResponse`, It was empty at the time of model creation.
        homeProviders = try values.decodeIfPresent(Providers.self, forKey: .homeProviders)
        recentServices = try values.decodeIfPresent(RecentServices.self, forKey: .recentServices)
        recommendedProviders = try values.decodeIfPresent(Providers.self, forKey: .recommendedProviders)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(lang, forKey: .lang)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(errorMsg, forKey: .errorMsg)
        try container.encodeIfPresent(errors, forKey: .errors)
        // TODO: Add code for encoding `defaultResponse`, It was empty at the time of model creation.
        try container.encodeIfPresent(homeProviders, forKey: .homeProviders)
        try container.encodeIfPresent(recentServices, forKey: .recentServices)
        try container.encodeIfPresent(recommendedProviders, forKey: .recommendedProviders)
    }
    
}


struct Errors: Codable {
    
}


class Providers: Codable {
    
    let data: [HomeProvidersDatum]?
    
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([HomeProvidersDatum].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(data, forKey: .data)
    }
    
}



class HomeProvidersDatum: Codable {
    
    let id: Int?
    let isMain: Bool?
    let businessName: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let mobile: String?
    let image: String?
    let bgImage: String?
    let phone: String?
    let yearId: Int?
    let businessSizeId: Int?
    let districtId: Int?
    let address: String?
    let latitude: String?
    let longitude: String?
    let about: Any?
    let websiteLink: Any?
    let facebookLink: Any?
    let twitterLink: Any?
    let instagramLink: Any?
    let active: Int?
    let visible: Int?
    let favorite: Bool?
    let subCategoryName: String?
    let categoryName: String?
    let imagesCount: Int?
    let rate: Int?
    let raters: Int?
    let minValue: Int?
    let maxValue: Int?
    let year: Year?
    let businessSize: BusinessSize?
    let district: DistrictData?
    let subCategory: SubCategory?
    let mainCategory: MainCategory?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case isMain = "is_main"
        case businessName = "business_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case mobile = "mobile"
        case image = "image"
        case bgImage = "bg_image"
        case phone = "phone"
        case yearId = "year_id"
        case businessSizeId = "business_size_id"
        case districtId = "district_id"
        case address = "address"
        case latitude = "latitude"
        case longitude = "longitude"
        case about = "about"
        case websiteLink = "website_link"
        case facebookLink = "facebook_link"
        case twitterLink = "twitter_link"
        case instagramLink = "instagram_link"
        case active = "active"
        case visible = "visible"
        case favorite = "favorite"
        case subCategoryName = "sub_category_name"
        case categoryName = "category_name"
        case imagesCount = "images_count"
        case rate = "rate"
        case raters = "raters"
        case minValue = "min_value"
        case maxValue = "max_value"
        case year = "year"
        case businessSize = "business_size"
        case district = "district"
//        case city = "city"
        case subCategory = "sub_category"
        case mainCategory = "main_category"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isMain = try values.decodeIfPresent(Bool.self, forKey: .isMain)
        businessName = try values.decodeIfPresent(String.self, forKey: .businessName)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        bgImage = try values.decodeIfPresent(String.self, forKey: .bgImage)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        yearId = try values.decodeIfPresent(Int.self, forKey: .yearId)
        businessSizeId = try values.decodeIfPresent(Int.self, forKey: .businessSizeId)
        districtId = try values.decodeIfPresent(Int.self, forKey: .districtId)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        about = nil // TODO: Add code for decoding `about`, It was null at the time of model creation.
        websiteLink = nil // TODO: Add code for decoding `websiteLink`, It was null at the time of model creation.
        facebookLink = nil // TODO: Add code for decoding `facebookLink`, It was null at the time of model creation.
        twitterLink = nil // TODO: Add code for decoding `twitterLink`, It was null at the time of model creation.
        instagramLink = nil // TODO: Add code for decoding `instagramLink`, It was null at the time of model creation.
        active = try values.decodeIfPresent(Int.self, forKey: .active)
        visible = try values.decodeIfPresent(Int.self, forKey: .visible)
        favorite = try values.decodeIfPresent(Bool.self, forKey: .favorite)
        subCategoryName = try values.decodeIfPresent(String.self, forKey: .subCategoryName)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        imagesCount = try values.decodeIfPresent(Int.self, forKey: .imagesCount)
        rate = try values.decodeIfPresent(Int.self, forKey: .rate)
        raters = try values.decodeIfPresent(Int.self, forKey: .raters)
        minValue = try values.decodeIfPresent(Int.self, forKey: .minValue)
        maxValue = try values.decodeIfPresent(Int.self, forKey: .maxValue)
        year = try values.decodeIfPresent(Year.self, forKey: .year)
        businessSize = try values.decodeIfPresent(BusinessSize.self, forKey: .businessSize)
        district = try values.decodeIfPresent(DistrictData.self, forKey: .district)
//        city = try values.decodeIfPresent(City.self, forKey: .city)
        subCategory = try values.decodeIfPresent(SubCategory.self, forKey: .subCategory)
        mainCategory = try values.decodeIfPresent(MainCategory.self, forKey: .mainCategory)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(isMain, forKey: .isMain)
        try container.encodeIfPresent(businessName, forKey: .businessName)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(mobile, forKey: .mobile)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(bgImage, forKey: .bgImage)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(yearId, forKey: .yearId)
        try container.encodeIfPresent(businessSizeId, forKey: .businessSizeId)
        try container.encodeIfPresent(districtId, forKey: .districtId)
        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(latitude, forKey: .latitude)
        try container.encodeIfPresent(longitude, forKey: .longitude)
        // TODO: Add code for encoding `about`, It was null at the time of model creation.
        // TODO: Add code for encoding `websiteLink`, It was null at the time of model creation.
        // TODO: Add code for encoding `facebookLink`, It was null at the time of model creation.
        // TODO: Add code for encoding `twitterLink`, It was null at the time of model creation.
        // TODO: Add code for encoding `instagramLink`, It was null at the time of model creation.
        try container.encodeIfPresent(active, forKey: .active)
        try container.encodeIfPresent(visible, forKey: .visible)
        try container.encodeIfPresent(favorite, forKey: .favorite)
        try container.encodeIfPresent(subCategoryName, forKey: .subCategoryName)
        try container.encodeIfPresent(categoryName, forKey: .categoryName)
        try container.encodeIfPresent(imagesCount, forKey: .imagesCount)
        try container.encodeIfPresent(rate, forKey: .rate)
        try container.encodeIfPresent(raters, forKey: .raters)
        try container.encodeIfPresent(minValue, forKey: .minValue)
        try container.encodeIfPresent(maxValue, forKey: .maxValue)
        try container.encodeIfPresent(year, forKey: .year)
        try container.encodeIfPresent(businessSize, forKey: .businessSize)
        try container.encodeIfPresent(district, forKey: .district)
//        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(subCategory, forKey: .subCategory)
        try container.encodeIfPresent(mainCategory, forKey: .mainCategory)
    }
    
}



//class Year: Codable {
//    
//    let id: Int?
//    let title: String?
//    
//    private enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case title = "title"
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(id, forKey: .id)
//        try container.encodeIfPresent(title, forKey: .title)
//    }
//    
//}
//


class BusinessSize: Codable {
    
    let id: Int?
    let title: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(title, forKey: .title)
    }
    
}




class DistrictData: Codable {
    
    let id: Int?
    let title: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(title, forKey: .title)
    }
    
}


//class City: Codable {
//    
//    let id: Int?
//    let name: String?
//    
//    private enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(id, forKey: .id)
//        try container.encodeIfPresent(name, forKey: .name)
//    }
//    
//}



class SubCategory: Codable {
    
    let id: Int?
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
    }
    
}



class MainCategory: Codable {
    
    let id: Int?
    let name: String?
    let icon: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case icon = "icon"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(icon, forKey: .icon)
    }
    
}




class RecentServices: Codable {
    
    let data: [serviceData]?
    
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([serviceData].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(data, forKey: .data)
    }
    
}



// service data

class serviceData: Codable {
    
    let id: Int?
    let name: String?
    let icon: String?
    let minValue: Any?
    let maxValue: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case icon = "icon"
        case minValue = "min_value"
        case maxValue = "max_value"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        minValue = nil // TODO: Add code for decoding `minValue`, It was null at the time of model creation.
        maxValue = try values.decodeIfPresent(Int.self, forKey: .maxValue)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(icon, forKey: .icon)
        // TODO: Add code for encoding `minValue`, It was null at the time of model creation.
        try container.encodeIfPresent(maxValue, forKey: .maxValue)
    }
    
}



class RecommendedProviders: Codable {
    
    let data: [recomendedproviderData]?
    
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([recomendedproviderData].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(data, forKey: .data)
    }
    
}



// recomended provider data

class recomendedproviderData: Codable {
    
    let id: Int?
    let isMain: Bool?
    let businessName: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let mobile: String?
    let image: String?
    let bgImage: String?
    let phone: String?
    let yearId: Int?
    let businessSizeId: Int?
    let districtId: Int?
    let address: String?
    let latitude: String?
    let longitude: String?
    let about: Any?
    let websiteLink: Any?
    let facebookLink: Any?
    let twitterLink: Any?
    let instagramLink: Any?
    let active: Int?
    let visible: Int?
    let favorite: Bool?
    let subCategoryName: String?
    let categoryName: String?
    let imagesCount: Int?
    let rate: Int?
    let raters: Int?
    let minValue: Int?
    let maxValue: Int?
    let year: Year?
    let businessSize: BusinessSize?
    let district: DistrictData?
    let city: City?
    let subCategory: SubCategory?
    let mainCategory: MainCategory?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case isMain = "is_main"
        case businessName = "business_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case mobile = "mobile"
        case image = "image"
        case bgImage = "bg_image"
        case phone = "phone"
        case yearId = "year_id"
        case businessSizeId = "business_size_id"
        case districtId = "district_id"
        case address = "address"
        case latitude = "latitude"
        case longitude = "longitude"
        case about = "about"
        case websiteLink = "website_link"
        case facebookLink = "facebook_link"
        case twitterLink = "twitter_link"
        case instagramLink = "instagram_link"
        case active = "active"
        case visible = "visible"
        case favorite = "favorite"
        case subCategoryName = "sub_category_name"
        case categoryName = "category_name"
        case imagesCount = "images_count"
        case rate = "rate"
        case raters = "raters"
        case minValue = "min_value"
        case maxValue = "max_value"
        case year = "year"
        case businessSize = "business_size"
        case district = "district"
        case city = "city"
        case subCategory = "sub_category"
        case mainCategory = "main_category"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isMain = try values.decodeIfPresent(Bool.self, forKey: .isMain)
        businessName = try values.decodeIfPresent(String.self, forKey: .businessName)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        bgImage = try values.decodeIfPresent(String.self, forKey: .bgImage)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        yearId = try values.decodeIfPresent(Int.self, forKey: .yearId)
        businessSizeId = try values.decodeIfPresent(Int.self, forKey: .businessSizeId)
        districtId = try values.decodeIfPresent(Int.self, forKey: .districtId)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        about = nil // TODO: Add code for decoding `about`, It was null at the time of model creation.
        websiteLink = nil // TODO: Add code for decoding `websiteLink`, It was null at the time of model creation.
        facebookLink = nil // TODO: Add code for decoding `facebookLink`, It was null at the time of model creation.
        twitterLink = nil // TODO: Add code for decoding `twitterLink`, It was null at the time of model creation.
        instagramLink = nil // TODO: Add code for decoding `instagramLink`, It was null at the time of model creation.
        active = try values.decodeIfPresent(Int.self, forKey: .active)
        visible = try values.decodeIfPresent(Int.self, forKey: .visible)
        favorite = try values.decodeIfPresent(Bool.self, forKey: .favorite)
        subCategoryName = try values.decodeIfPresent(String.self, forKey: .subCategoryName)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        imagesCount = try values.decodeIfPresent(Int.self, forKey: .imagesCount)
        rate = try values.decodeIfPresent(Int.self, forKey: .rate)
        raters = try values.decodeIfPresent(Int.self, forKey: .raters)
        minValue = try values.decodeIfPresent(Int.self, forKey: .minValue)
        maxValue = try values.decodeIfPresent(Int.self, forKey: .maxValue)
        year = try values.decodeIfPresent(Year.self, forKey: .year)
        businessSize = try values.decodeIfPresent(BusinessSize.self, forKey: .businessSize)
        district = try values.decodeIfPresent(DistrictData.self, forKey: .district)
        city = try values.decodeIfPresent(City.self, forKey: .city)
        subCategory = try values.decodeIfPresent(SubCategory.self, forKey: .subCategory)
        mainCategory = try values.decodeIfPresent(MainCategory.self, forKey: .mainCategory)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(isMain, forKey: .isMain)
        try container.encodeIfPresent(businessName, forKey: .businessName)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(mobile, forKey: .mobile)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(bgImage, forKey: .bgImage)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(yearId, forKey: .yearId)
        try container.encodeIfPresent(businessSizeId, forKey: .businessSizeId)
        try container.encodeIfPresent(districtId, forKey: .districtId)
        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(latitude, forKey: .latitude)
        try container.encodeIfPresent(longitude, forKey: .longitude)
        // TODO: Add code for encoding `about`, It was null at the time of model creation.
        // TODO: Add code for encoding `websiteLink`, It was null at the time of model creation.
        // TODO: Add code for encoding `facebookLink`, It was null at the time of model creation.
        // TODO: Add code for encoding `twitterLink`, It was null at the time of model creation.
        // TODO: Add code for encoding `instagramLink`, It was null at the time of model creation.
        try container.encodeIfPresent(active, forKey: .active)
        try container.encodeIfPresent(visible, forKey: .visible)
        try container.encodeIfPresent(favorite, forKey: .favorite)
        try container.encodeIfPresent(subCategoryName, forKey: .subCategoryName)
        try container.encodeIfPresent(categoryName, forKey: .categoryName)
        try container.encodeIfPresent(imagesCount, forKey: .imagesCount)
        try container.encodeIfPresent(rate, forKey: .rate)
        try container.encodeIfPresent(raters, forKey: .raters)
        try container.encodeIfPresent(minValue, forKey: .minValue)
        try container.encodeIfPresent(maxValue, forKey: .maxValue)
        try container.encodeIfPresent(year, forKey: .year)
        try container.encodeIfPresent(businessSize, forKey: .businessSize)
        try container.encodeIfPresent(district, forKey: .district)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(subCategory, forKey: .subCategory)
        try container.encodeIfPresent(mainCategory, forKey: .mainCategory)
    }
    
}


*/
