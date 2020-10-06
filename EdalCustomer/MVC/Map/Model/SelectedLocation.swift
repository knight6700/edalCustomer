//
//  SelectedLocation.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/26/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

class SelectedLocation {
    var address: String
    var latitude: Double
    var longitude: Double
    
    init() {
        self.address = ""
        self.latitude = 0.0
        self.longitude =  0.0
    }
    
    init(address: String, latitude: Double, longitude: Double) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}
