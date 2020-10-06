//
//  MyEdalServices.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 11/6/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation


class MyEdalServices {
    
    func getUpcomingBooking(completion: @escaping (_ error: String?, _ data: SearchLookUpsResponse?) -> ()){
        
        let url = URLs.base + "/api/customer/booking/list"
        
        let parameters:[String: Any] = ["device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: SearchLookUpsResponse?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            guard data.status == "1" else {
                completion(data.errorMsg, nil)
                return
            }
            
            completion(nil, data)
        }
    }
    
    func getSubCategory(by categoryId: Int, completion: @escaping (_ error: String?, _ data: SubCategoriesResponse?) -> ()){
        
        let url = URLs.base + "/api/customer/search/categories/sub-categories"
        
        let parameters:[String: Any] = ["category_id": categoryId,
                                        "device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: SubCategoriesResponse?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            guard data.status == "1" else {
                completion(data.error_msg, nil)
                return
            }
            
            completion(nil, data)
        }
    }
    
    func getServicesSubCategory(by subCategoryId: Int, completion: @escaping (_ error: String?, _ data: ServicesSubCategoriesResponse?) -> ()){
        
        let url = URLs.base + "/api/customer/search/categories/sub-categories/services"
        
        let parameters:[String: Any] = ["sub_category_id": subCategoryId,
                                        "device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: ServicesSubCategoriesResponse?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            guard data.status == "1" else {
                completion(data.error_msg, nil)
                return
            }
            
            completion(nil, data)
        }
    }
    
}
