//
//  BusinessProfileServices.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/8/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import Alamofire

class BusinessprofileServices {
    
    func getProfileDetails(for providerId: Int, completion: @escaping (_ error: String?, _ data: BusinessProfileDetailsResponse?) -> ()) {
        
        let url = URLs.base + "/api/customer/search/provider/details"
        
        let parameters:[String: Any] = ["provider_id": providerId,
                                        "device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
             
        }
    }
    
    func getProviderSubServices(for providerId: Int, completion: @escaping (_ error: String?, _ data: BusinessProfileDetailsResponse?) -> ()){
        
        let url = URLs.base + "api/customer/search/provider/sub-services"
        
        let parameters:[String: Any] = ["provider_id": providerId,
                                        "device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
//            
//            guard data.status == "1" else {
//                completion(data.error_msg, nil)
//                return
//            }
//            
//            completion(nil, data)
        }
    }
    
    func getProviderDetailsReviews(for providerId: Int, completion: @escaping (_ error: String?, _ data: BusinessProfileDetailsResponse?) -> ()){
        
        let url = URLs.base + "/api/customer/search/provider/get-reviews"
        
        let parameters:[String: Any] = ["provider_id": providerId,
                                        "device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
//            guard data.status == "1" else {
//                completion(data.error_msg, nil)
//                return
//            }
//
//            completion(nil, data)
        }
    }
    
    
    func reportReasons(for providerId: Int, completion: @escaping (_ error: String?, _ data: BusinessProfileDetailsResponse?) -> ()){
        
        let url = URLs.base + "/api/customer/report/reasons"
        
        let parameters:[String: Any] = ["provider_id": providerId,
                                        "device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
//
//            guard data.status == "1" else {
//                completion(data.error_msg, nil)
//                return
//            }
//
//            completion(nil, data)
        }
    }
    
    func reportProvider(for providerId: Int, completion: @escaping (_ error: String?, _ data: BusinessProfileDetailsResponse?) -> ()){
        
        let url = URLs.base + "/api/customer/report/add"
        
        let parameters:[String: Any] = ["provider_id": providerId,
                                        "device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
//            guard data.status == "1" else {
//                completion(data.error_msg, nil)
//                return
//            }
//
//            completion(nil, data)
        }
    }
    
    
    
}
