//
//  CategoriesServices.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/19/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
class CategoriesServices {
    
    func getAllCategories(for page: Int, completion: @escaping (_ error: String?, _ data: CategoryResponseModel?) -> ()){
        
        let url = URLs.base + "/api/customer/search/categories/all"
      
        let parameters:[String: Any] = [/*"page": page,*/
                                        "device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang])
    // "send verificatione code" for forgot password
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
                 
              if let error = error {
                   completion(error, nil)
                   return
               }
               
               guard let mainResponse = Mapper<CategoryResponseModel>().map(JSON: data!) else {
                   completion("error occurred please try again later" ,nil)
                   return
               }
               
               guard mainResponse.status == "1" else {
                   completion(mainResponse.error_msg, nil)
                   return
               }
               
               completion(nil, mainResponse)
               
           }
        
    }
    
   
   
    
    func updateFavoriteCategory(withCategoriesIds categoryIds: [Int], completion: @escaping (_ error: String?, _ data: FavoriteCategories?) -> Void){
        let url = URLs.base + "/api/customer/profile/update-my-categories"
        let parameters:[String: Any] = ["categories": categoryIds,
                                        "device_type": "2"]
        
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: FavoriteCategories?) in
            
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
    
    func getAllCities( completion: @escaping (_ error: String?, _ data: SearchLookUpsResponse?) -> ()) {
        ApiClient.CallApi(endPoint: .city) { (data: SearchLookUpsResponse?, error: Error?, code) in
            ApiClient.checkErrors(error: error?.localizedDescription, errorSubCategories: data?.errors.subServiceID, completion: completion)
            completion(nil,data)
        }
    }
    
    
    
    
}
