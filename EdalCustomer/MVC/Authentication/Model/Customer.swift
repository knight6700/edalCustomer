//
//  ProviderUser.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/31/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

struct Customer: Decodable {
    let id: Int
    let age: LookupAllData
    let api_token: String?
    let first_name: String
    let image: String?
    let last_name: String
    let mobile: String
    let email: String
    let gender: Int
    let age_id: Int
    let district_id: Int
    let location: String
    let latitude: String
    let longitude: String
}
