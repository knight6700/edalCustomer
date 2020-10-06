//
//  ProfileServices.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/20/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import Alamofire

class ProfileServices {
    
    
    
    func updateImage(withImage image: UIImage, completion: @escaping (_ error: String?, _ uploadPhotoResponse: UpdateImageResponse?) -> Void){
        
        let url = URLs.base + "/api/customer/profile/update-image"
        let parameters = ["device_type":"2"]
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        /*
        Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
            guard let data = image.jpegData(compressionQuality: 0.5) else { return }
            guard let mediaImage = Media(withData: data, forKey: "image", mimeType: "image/jpeg", fileName: "photo\(arc4random()).jpeg") else { return }
            form.append(mediaImage.data, withName: mediaImage.key, fileName: mediaImage.fileName, mimeType: mediaImage.mimeType)
            
            // if there is parameters
            for (key, value) in parameters {
                form.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .failure(let error):
                print("error in encoding photo: \(error.localizedDescription)")
                completion("error while uploading image, please try again later", nil)
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("progress is here1 \(progress.fractionCompleted)")
                })
                    
                    .responseJSON(completionHandler: { (response) in
                        switch response.result{
                        case .failure(let error):
                            print("error in uploadSinglePhoto : \(error.localizedDescription)")
                            completion("error while uploading image, please try again later", nil)
                        case .success(_):
                            guard let _data = response.data else {
                                completion("error while uploading image, please try again later", nil)
                                return
                            }
                            
                            do{
                                
                                let data = try JSONDecoder().decode(UpdateImageResponse.self, from: _data)
                                completion(nil, data)
                                
                            } catch{
                                print(error)
                                completion("error in decoding", nil)
                            }
                        }
                    })
            }
        }
    */
    }
    
    func getCustomerPersonalInfo(completion: @escaping (_ error: String?, _ data: GetCustomerResponse?) -> Void){
        let url = URLs.base + "/api/customer/profile/personal-info"
        let parameters:[String: Any] = ["device_type": "2"]
        
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: GetCustomerResponse?) in
            
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
    
    
    func updatePassword(passowrd: String, newPassword: String, confirmPassword: String,  completion: @escaping (_ error: String?, _ data: RegisterResponse?) -> Void){
        let url = URLs.base + "/api/customer/profile/personal-info/password/update"
        let parameters:[String: Any] = ["device_type": "2"]
        
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
    
    func updateCustomerPersonalInfo(firstName: String, lastName: String, email: String, gender: Int, age: Int,  completion: @escaping (_ error: String?, _ errors: [String: String]?, _ data: GetCustomerResponse?) -> Void){
        let url = URLs.base + "}/api/customer/profile/personal-info/update"
        let parameters:[String: Any] = ["device_type": "2",
                                        "first_name": firstName,
                                        "last_name": lastName,
                                        "email": email,
                                        "gender": gender,
                                        "age": age]
        
        let headers = RequestComponent.headerComponent([.lang , .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: GetCustomerResponse?) in
            
           
            if let error = error {
                completion(error, nil, nil)
                return
            }
            
            guard let data = data else {
                completion(nil, nil, nil)
                return
            }
            
            guard data.status == "1" else {
                completion(nil, data.errors, nil)
                return
            }
            
            completion(nil, nil, data)
        }
    }
    func updateCustomerAddress(districtId: Int, location: String, latitude: Double, longitude: Double, completion: @escaping (_ error: String?, _ data: RegisterResponse?) -> Void){
        let url = URLs.base + "/api/customer/profile/personal-info/address/update"
        let parameters:[String: Any] = ["device_type": "2",
                                        "district_id": districtId,
                                        "location": location,
                                        "latitude": latitude,
                                        "longitude":longitude
        ]
        
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
    
    func updateFavoriteCategories(){
        
    }
    

    
}
