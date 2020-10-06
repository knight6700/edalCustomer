//
//  APIConfigurations.swift
//  MacQueen
//
//  Created by Mahmoud Fares on 12/2/19.
//  Copyright © 2019 Mahmoud Fares. All rights reserved.
//

import Alamofire
protocol APIConfigurations: URLRequestConvertible {
    var method: HTTPMethod {get}
    var path: String {get}
    var parameters: Parameters? {get}
}
