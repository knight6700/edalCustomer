//
//  LookupDistricts.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/31/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

class LookupDistricts: Decodable {
    let lang: String
    let status: String
    let error_msg: String
    let errors : [String: String]
    let districts: Districts
}

class Districts: Decodable {
    let data: [LookupAllData]
}
