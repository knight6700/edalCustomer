//
//  SearchServices.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/30/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation

class SearchServices {
    
    func getSearchLookUps(completion: @escaping (_ error: String?, _ data: SearchLookUpsResponse?) -> ()){
        
        let url = URLs.base + "/api/customer/search/lookups"
        
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
    
    
    func getProviderServices(by servicesId: Int,by page: Int ,completion: @escaping (_ error: String?, _ data: ProviderServicesResponse?) -> ()){
        
        let url = URLs.base + "/api/customer/search/categories/services/providers"
        
        let parameters:[String: Any] = ["service_id": servicesId,
                                        "page": page,
                                        "device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: ProviderServicesResponse?) in
            
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
    
    
    func search(byKeyword search: String?, byDistrict district_id: Int? ,byDate date: String?, byTime time: String?, byPage page: Int?, byMinPrice min_price: Int?, byMaxPrice max_price: Int?,byLocationRange location_range: Int?, byCategoryId category_id: Int?, byRatingFrom rating_from: Int?, byRatingTo rating_to:Int?, bySorting sorting: Int?,locationRange: Int?, completion: @escaping (_ error: String?, _ data: ProviderServicesResponse?) -> ()){
        
        let url = URLs.base + "/api/customer/search"
        
        var parameters:[String: Any] = ["device_type": "2"]

        if let search = search, !search.isEmpty {
           parameters["search"] = search
        }
        
        if district_id != nil && district_id != 0 {
           parameters["district_id"] = district_id
        }
        
        if let date = date, !date.isEmpty {
            parameters["date"] = date
        }
        if let time = time, !time.isEmpty {
           parameters["time"] = time
        }
        if let page = page{
            parameters["page"] = page
        }
        if min_price != nil {
           parameters["min_price"] = min_price
        }
        if max_price != nil {
            parameters["max_price"] = max_price
            
        }
        if location_range != nil {
            parameters["location_range"] = location_range
        }
        if rating_from != nil {
           parameters["rating_from"] = rating_from
        }
        if rating_to != nil {
            parameters["rating_to"] = rating_to
        }
        if sorting != nil {
            parameters["sorting"] = sorting
        }
        if locationRange != nil {
           parameters["location_range"] = locationRange
        }
        print(parameters)
        print("asd")
        let headers = RequestComponent.headerComponent([.lang])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: ProviderServicesResponse?) in
            print(url)
            print(parameters)
            print()
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

