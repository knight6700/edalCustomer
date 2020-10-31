//
//  Media.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/20/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class Media {
    
    let key: String
    let fileName: String
    let data: Data
    var mimeType: String
    
    init?(withData data: Data, forKey key: String, mimeType: String, fileName: String) {
        self.data = data
        self.key = key
        self.mimeType = mimeType
        self.fileName = fileName
    }
}

