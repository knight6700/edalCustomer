//
//  LookupAllData.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/31/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

struct LookupAllData: Codable {
    let id: Int         // for all
    let title: String?  // for business_sizes, years_of_experience, districts
    let name: String?   // for categories, cities
    let icon: String?   // for categories
}
