//
//  BookAppointment.swift
//  EdalCustomer
//
//  Created by Mahmoud Fares on 10/26/20.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import Foundation
struct BookAppointment: Codable {
    var lang, status, errorMsg: String?
    var errors: Errors?
    var defaultResponse: DefaultResponseBooking?

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
struct DefaultResponseBooking: Codable {
    var bookID: Int?

    enum CodingKeys: String, CodingKey {
        case bookID = "book_id"
    }
}
