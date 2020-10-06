//
//  SearchLooksUpsResponse.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/18/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

class SearchLookUpsResponse: Decodable {
    let lang, status, errorMsg: String
    let errors: Errors
    let defaultResponse: SearchLooksupDefaultResponse
    
    enum CodingKeys: String, CodingKey {
        case lang, status
        case errorMsg = "error_msg"
        case errors
        case defaultResponse = "default_response"
    }
}

class SearchLooksupDefaultResponse: Decodable {
    let citiesDistricts: CitiesDistricts
    let priceRangeMax, locationRangeMax: Int
    
    enum CodingKeys: String, CodingKey {
        case citiesDistricts = "cities_districts"
        case priceRangeMax = "price_range_max"
        case locationRangeMax = "location_range_max"
    }
}

class CitiesDistricts: Decodable {
    let data: [CitiesDistrictsDatum]
}

class CitiesDistrictsDatum: Decodable {
    let id: Int
    let name: String
    let districts: District
}
class District: Decodable {
    let data: [DistrictDatum]
}
class DistrictDatum: Decodable {
    let id: Int
    let title: String
}
