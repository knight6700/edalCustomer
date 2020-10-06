//
//  ComplaintsServices.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/16/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation


class ComplaintsServices {
    func createComplaints(bookId: Int, reasonId: Int, message: String, completion: @escaping (_ error: String?, _ data: RegisterResponse?) -> Void){
        let url = URLs.base + "/api/customer/complaints/create"
        let parameters:[String: Any] = ["device_type": "2",
                                        "book_id": bookId,
                                        "reason_id": reasonId,
                                        "message": message]
        
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: RegisterResponse?) in
            
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
    
    func getAllComplaintsReasons(bookId: Int, reasonId: Int, message: String, completion: @escaping (_ error: String?, _ data: RegisterResponse?) -> Void){
        let url = URLs.base + "/api/customer/complaints/reasons"
        let parameters:[String: Any] = ["device_type": "2",
                                        "book_id": bookId,
                                        "reason_id": reasonId,
                                        "message": message]
        
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: RegisterResponse?) in
            
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
    
    
    func listComplaints(listType: String, status: String, ids: [Int], completion: @escaping (_ error: String?, _ data: RegisterResponse?) -> Void){
        let url = URLs.base + "/api/customer/complaints"
        let parameters:[String: Any] = ["device_type": "2",
                                        "list_type": listType,
            "status": status,
            "ids":  ids]
        
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: RegisterResponse?) in
            
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
    
    func getComplaintsDetails(complaintId: Int, completion: @escaping (_ error: String?, _ data: RegisterResponse?) -> Void){
        let url = URLs.base + "/api/customer/complaints/details"
        let parameters:[String: Any] = ["device_type": "2",
                                        "complaint_id": complaintId]
        
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: RegisterResponse?) in
            
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
    
    func closeComplaints(complaintId: String, comment: String, completion: @escaping (_ error: String?, _ data: RegisterResponse?) -> Void){
        let url = URLs.base + "/api/customer/complaints/close"
        let parameters:[String: Any] = ["device_type": "2",
                                        "complaint_id": complaintId,
                                        "comment": comment]
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: RegisterResponse?) in
            
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
    
    
    func countComplaints(status: String, completion: @escaping (_ error: String?, _ data: RegisterResponse?) -> Void){
        let url = URLs.base + "/api/customer/complaints/count"
        let parameters:[String: Any] = ["device_type": "2",
                                        "status": status]
        
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: RegisterResponse?) in
            
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
