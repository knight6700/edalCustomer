//
//  LookupAll.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/31/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

class LookupAll: Decodable {
    let lang: String = ""
    let status: String = ""
    let error_msg: String = ""
    let errors : [String: String] = [:]
    //let business_sizes: BusinessSize?
    //let years_of_experience: YearsExperience?
    //let categories: Categories?
    let cities: Cities
    let ages: Ages
    let terms: String = ""
}

class Cities: Decodable {
    let data: [LookupAllData]
}
class Ages: Decodable {
    let data: [LookupAllData]
}



