//
//  UpCommeingDealsResponse.swift
//  EdalCustomer
//
//  Created by Mahmoud Fares on 10/9/20.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import Foundation
struct UpCommingResponse: Codable {
    var lang, status, errorMsg: String?
    var errors: Errors?
    var defaultResponse: UpCommingDefaultResponse?

    enum CodingKeys: String, CodingKey {
        case lang, status
        case errorMsg = "error_msg"
        case errors
        case defaultResponse = "default_response"
    }
}

// MARK: - DefaultResponse
struct UpCommingDefaultResponse: Codable {
    var books: Books?
}

// MARK: - Books
struct Books: Codable {
    var data: [Datum]?
    var meta: Meta?
}

// MARK: - Datum
struct Datum: Codable {
    var id, customerID: Int?
    var customerName: String?
    var customerImage: String?
    var providerID: Int?
    var providerName: String?
    var providerImage: String?
    var subServiceTitle, resourceName, startDate, from: String?
    var to, endDate: String?
    var status: Int?
    var statusText: String?
    var price: Float?

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case customerName = "customer_name"
        case customerImage = "customer_image"
        case providerID = "provider_id"
        case providerName = "provider_name"
        case providerImage = "provider_image"
        case subServiceTitle = "sub_service_title"
        case resourceName = "resource_name"
        case startDate = "start_date"
        case from, to
        case endDate = "end_date"
        case status
        case statusText = "status_text"
        case price
    }
}

// MARK: - Meta
struct Meta: Codable {
    var pagination: Pagination?
}

// MARK: - Pagination
struct Pagination: Codable {
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
