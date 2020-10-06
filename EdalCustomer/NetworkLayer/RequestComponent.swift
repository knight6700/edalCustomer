//
//  RequestComponent.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/25/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import Alamofire

class RequestComponent{
    
    enum Component {
        case lang
        case authorization
    }
    
    class func headerComponent(_ component: [Component]) -> HTTPHeaders {
        var header = HTTPHeaders()
        
        for singleComponent in component{
            switch singleComponent{
            case .lang:
                header["lang"] = LanguageManger.shared.currentLanguage.rawValue
            case .authorization:
                header["Authorization"] = "Bearer " + Defaults.token
            }
        }
        
        return header
    }
    
    
}
