//
//  FavoriteProviderServices.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/15/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
class FavoriteProviderServices{
    // for update favorite provider search 4 update favorite provider
    func updateFavoriteProvider(withProviderId providerId: Int, favorite: Int, completion: @escaping (_ error: String?, _ data: FavoriteProvider?) -> Void){
        let parameters:[String: Any] = ["provider_id": providerId,
                                        "favorite": favorite,
                                        "device_type": "2"]

        ApiClient.CallApi(endPoint: .updateMyFavorites(parameters: parameters)) { (data: FavoriteProvider? , error: Error?, code) in
            guard error == nil  else {
                completion(error?.localizedDescription, nil)
                return
            }
            completion(nil, data)
        }
        let url = URLs.base + "/api/customer/profile/update-my-favorites"
        
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: FavoriteProvider?) in
            
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
    
    func getFavoriteProvider(page: Int, completion: @escaping (_ error: String?, _ data: FavoriteProvider?) -> Void){
        let url = URLs.base + "/api/customer/profile/personal-info/favorite-list"
        let parameters:[String: Any] = ["device_type": "2",
                                        "page": page]
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: FavoriteProvider?) in
            
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


