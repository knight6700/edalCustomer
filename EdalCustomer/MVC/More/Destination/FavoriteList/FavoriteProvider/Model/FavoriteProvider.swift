//
//  FavoriteProvider.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/28/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

struct Errors: Codable {
    
}
class FavoriteProvider: Codable {
    let lang, status, error_msg: String?
    let errors: Errors?

   // let default_response: ProviderResponse?
    private enum CodingKeys: String, CodingKey {
        case lang = "lang"
        case status = "status"
        case errorMsg = "error_msg"
        case errors = "errors"
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lang = try values.decodeIfPresent(String.self, forKey: .lang)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        error_msg = try values.decodeIfPresent(String.self, forKey: .errorMsg)
        errors = try values.decodeIfPresent(Errors.self, forKey: .errors)
        }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(lang, forKey: .lang)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(error_msg, forKey: .errorMsg)
        try container.encodeIfPresent(errors, forKey: .errors)
        // TODO: Add code for encoding `defaultResponse`, It was empty at the time of model creation.
      
    }

}

//class ProviderResponse: Decodable {
//    let providers: ServicesProvidersModel
//}
