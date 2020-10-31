//
//  EndPoints.swift
//  MacQueen
//
//  Created by Mahmoud Fares on 12/2/19.
//  Copyright © 2019 Mahmoud Fares. All rights reserved.
//
import Foundation
import Alamofire
enum EndPoints: APIConfigurations {
    
    case updateMyFavorites(parameters:[String:  Any])
    case subService(id: String)
    case bookingList(parameters: [String: Any])
    case bookingHistory(parameters: [String: Any])
    case city
    case search(parameters: [String: Any])
    case book(parameters: BookingParameters)
    case favorite(page: Int)
    var method: HTTPMethod {
        switch self {
        case .updateMyFavorites, .subService, .bookingList, .bookingHistory, .city,.search, .book,.favorite:
            return .post
        }
    }

    internal var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        case .post:
          return  JSONEncoding.default
        default:
           return JSONEncoding.default
    }
    }

    var path: String {
        switch self {
        case .updateMyFavorites:
            return "customer/profile/update-my-favorites"
        case .subService(let id):
            return "customer/booking/sub-service?device_type=2&sub_service_id=\(id)"
        case .bookingList:
            return "customer/booking/list"
        case .bookingHistory:
            return "customer/booking/history"
        case .city:
            return "customer/search/lookups"
        case .search:
            return "customer/search"
        case .book:
            return "customer/booking/book"
        case .favorite:
            return "customer/profile/personal-info/favorite-list"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .updateMyFavorites(let parameters), .bookingList(let parameters), .bookingHistory(let parameters), .search(let parameters):
            return parameters
        case .book(let parameters) :
            return parameters.dictionary
        case .subService, .city:
            return ["device_type": "2"]
        case .favorite(let page):
            return ["device_type": "2",
                    "page":"\(page)"]
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = Constants.ProductionServer.baseUrl + path
        let finalURl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        var urlRequest = URLRequest(url: URL(string: finalURl)!)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        print(url)
        // Common Headers
//        if path == "RedeemList" {
//            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        }
//        if UserDefaults.standard.value(forKey: "userData") != nil {
//            let data  = UserDefaults.standard.value(forKey: "userData") as! [String: String]
//            let header = "Bearer " + data["token"]!
        let authHeader = "Bearer " + Defaults.token
        let lang = LanguageManger.shared.currentLanguage.rawValue

        urlRequest.setValue(authHeader, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(lang, forHTTPHeaderField: "lang")
        
//        }
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        if let parameters = parameters {
            do {
                print("PARMAETERS \(parameters)")
                urlRequest = try encoding.encode(urlRequest, with: parameters)
                let body = try JSONSerialization.data(withJSONObject: parameters)
                urlRequest.httpBody = body
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        // Parameters
        return  urlRequest

    }

}
