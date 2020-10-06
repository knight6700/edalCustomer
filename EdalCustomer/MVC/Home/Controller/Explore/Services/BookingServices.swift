//
//  BookingServices.swift
//  edal-IosCustomerApp
//
//  Created by Mahmoud Maamoun on 2/2/20.
//  Copyright © 2020 hesham ghalaab. All rights reserved.
//

import Foundation
import ObjectMapper
class BookingServices {
    
    func getSubBookingService(sub_service_id:Int, completion: @escaping (_ error: String?, _ subserviceInfoResponse: SubServiceDefaultResponse?) -> Void){
        
        let url = URLs.base + "/api/customer/booking/sub-service?device_type=2&sub_service_id=\(sub_service_id)"
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: [:], andHeaders: headers) { (error, data) in
            guard let _ = data else {
                guard let err = error else {
                   return
                }
                completion(err, nil)
                return
            }
            
            guard let subservResponse = Mapper<SubServiceBooking>().map(JSON: data!) else {
                
                completion(error, nil)
                return
            }
            if let error = error {
                completion(error, nil)
                return
            }
            else {
                if let toAdd = subservResponse.default_response {
                    completion(nil,toAdd)
                }
            }
            
        }
    }
}
