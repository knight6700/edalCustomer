//
//  HomeServices.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/26/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import  Foundation
import ObjectMapper
class HomeServices {
    
    
    
    func getHome( completion: @escaping (_ error: String?, _ uploadPhotoResponse: HomeResponseModel?) -> Void){
        
        let url = URLs.base + "/api/customer/home"
        let parameters = ["device_type":"2"]
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
              if let error = error {
                          completion(error, nil)
                          return
                      }
                      guard let mainResponse = Mapper<HomeResponseModel>().map(JSON: data!) else {
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
    

    func searchWithFilter(){
        
    }

}


