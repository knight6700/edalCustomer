//
//  ServiceItemDetailsModel.swift
//  EdalCustomer
//
//  Created by Mahmoud Fares on 10/8/20.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import Foundation

// MARK: - ServiceItemDetailsResponseModel
struct ServiceItemDetailsResponseModel: Codable {
    var lang, status, errorMsg: String?
    var errors: Errors?
    var defaultResponse: DefaultResponse?

    enum CodingKeys: String, CodingKey {
        case lang, status
        case errorMsg = "error_msg"
        case errors = "errors"
        case defaultResponse = "default_response"
    }
}

// MARK: - DefaultResponse
struct DefaultResponse: Codable {
    var subService: SubServicee?
    var resources: Resourcess?

    enum CodingKeys: String, CodingKey {
        case subService = "sub_service"
        case resources
    }
}

// MARK: - Resources
struct Resourcess: Codable {
    var data: [ResourcesDatumm]?
}

// MARK: - ResourcesDatum
struct ResourcesDatumm: Codable {
    var id: Int?
    var name, position: String?
    var image: String?
    var bio: String?
    var gender, status: Int?
    var datesTimes: [DatesTime]?

    enum CodingKeys: String, CodingKey {
        case id, name, position, image, bio, gender, status
        case datesTimes = "dates_times"
    }
}

// MARK: - DatesTime
struct DatesTime: Codable {
    var date: String?
    var times: [Time]?
}

// MARK: - Time
struct Time: Codable {
    var from: String?
    var to: String?
}


// MARK: - SubService
struct SubServicee: Codable {
    var id: Int?
    var title, serviceName: String?
    var location: Int?
    var subServiceDescription: String?
    var type: Int?
    var classCapacity: String?
    var instant, price: Int?
    var step2: Bool?
    var rotation, fixed: Int?
    var fixedHours: String?
    var step3, step4: Bool?
    var paymentMethod, deposit: Int?
    var bookingQuestion: String?
    var timeBeforeValue, timeInAdvanceType, timeInAdvanceValue, paddingValue: Int?
    var creationDate, lastUpdated: String?
    var status: Int?
    var service: Servicee?
    var daily: Daily?
    var weekly, monthly, seasonal: Resourcess?

    enum CodingKeys: String, CodingKey {
        case id, title
        case serviceName = "service_name"
        case location
        case subServiceDescription = "description"
        case type
        case classCapacity = "class_capacity"
        case instant, price, step2, rotation, fixed
        case fixedHours = "fixed_hours"
        case step3, step4
        case paymentMethod = "payment_method"
        case deposit
        case bookingQuestion = "booking_question"
        case timeBeforeValue = "time_before_value"
        case timeInAdvanceType = "time_in_advance_type"
        case timeInAdvanceValue = "time_in_advance_value"
        case paddingValue = "padding_value"
        case creationDate = "creation_date"
        case lastUpdated = "last updated"
        case status, service, daily, weekly, monthly, seasonal
    }
}

// MARK: - Daily
struct Daily: Codable {
    var data: [DailyDatum]?
}

// MARK: - DailyDatum
struct DailyDatum: Codable {
    var id, day: Int?
    var from: String?
    var to: String?
}

// MARK: - Service
struct Servicee: Codable {
    var id: Int?
    var name, icon: String?
    var minValue, maxValue: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, icon
        case minValue = "min_value"
        case maxValue = "max_value"
    }
}
