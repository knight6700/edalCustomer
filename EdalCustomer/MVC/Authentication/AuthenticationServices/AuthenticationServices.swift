//
//  AuthenticationServices.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/26/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

import ObjectMapper

class AuthenticationServices{
    
    
    func sendVerificationCode(withMobile mobile: String, completion: @escaping (_ error: String?, _ data: VerifyCodeResponseModel?) -> ()){
        
        // "send verificatione code" for forgot password
        let url = URLs.base + "/api/customer/auth/reset/code"
        let parameters:[String: Any] = ["mobile": mobile,
                                        "device_type": "2"]
        
        let headers = RequestComponent.headerComponent([.lang])
               RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
              
           if let error = error {
                completion(error, nil)
                return
            }
            
            guard let mainResponse = Mapper<VerifyCodeResponseModel>().map(JSON: data!) else {
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
    
    func reSendVerificationCode(withMobile mobile: String, completion: @escaping (_ error: String?, _ data: VerifyCodeResponseModel?) -> ()){
        // "Change Mobile Number" in case that user register or need to change mobile
        let url = URLs.base + "/api/customer/auth/code/resend"
        let parameters:[String: Any] = ["mobile": mobile,
                                        "device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            guard let mainResponse = Mapper<VerifyCodeResponseModel>().map(JSON: data!) else {
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
    
    
    /* Register */
    //////////////////////////////////////////////////////////////////////////////////
    //MARK:- Resend Code
    func verifyCode(withCode code: String, mobile: String,  completion: @escaping (_ error: String?, _ data: VerifyCodeResponseModel?) -> ()){
        let url = URLs.base + "/api/customer/auth/code/verify"
        let parameters:[String: Any] = ["mobile": mobile,
                                        "code": code,
                                        "device_type": "2"]
        
        let headers = RequestComponent.headerComponent([.lang])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            guard let mainResponse = Mapper<VerifyCodeResponseModel>().map(JSON: data!) else {
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
    
    //////////////////////////////////////////////////////////////////////////////////
    //MARK:- Resend Code
    func resetPassword(withMobile mobile: String, code: String, password: String, completion: @escaping (_ error: String?, _ data: VerifyCodeResponseModel?) -> ()){
        // "Change Mobile Number" in case that user register or need to change mobile
        let url = URLs.base + "/api/customer/auth/reset/password"
        let parameters:[String: Any] = ["mobile": mobile,
                                        "code": code,
                                        "password": password,
                                        "password_confirmation": password,
                                        "device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            
            guard let mainResponse = Mapper<VerifyCodeResponseModel>().map(JSON: data!) else {
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
    
    
    /// /////////////////////////  //////////////////////////////////////////////////////
   //MARK:- Validate User
    func validateUserData(withEmail email: String, mobile: String, completion: @escaping (_ error: String?, _ errors: [String: String]? , _ data: ValidationResponseModel?) -> ()){
        let parameters = [ "device_type":"2",
                           "email": email,
                           "mobile": mobile]
        let url = URLs.base + "/api/customer/auth/validate"
        let headers = RequestComponent.headerComponent([.lang])
       RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
                   
                   if let error = error {
                       completion(error, nil, nil)
                       return
                   }
                  
                   guard let mainResponse = Mapper<ValidationResponseModel>().map(JSON: data!) else {
                       completion("error occurred please try again later" ,nil, nil)
                       return
                   }
                 
                   
                   guard mainResponse.status == "1" else {
                       completion(nil, mainResponse.errors, nil)
                       return
                   }
                   
                   completion(nil, nil, mainResponse)
        }
    }
    
    /// ///////////////////////////////////////////////////////////////////////////////
    
    //MARK:- Register
    func registerUser(completion: @escaping (_ error: String?, _ data: RegisterResponseModel?) -> ()){
        var url = URLs.base + "/api/customer/auth/register"
        var parameters: [String: Any] = [:]
        
        if Defaults.SocialId != "" && Defaults.SocialProvider != "" && Defaults.SocialToken != "" {
             url = URLs.base + "/api/customer/auth/social-register"
             parameters = ["first_name": Defaults.FirstName,
                                          "last_name": Defaults.LastName,
                                          "mobile": Defaults.Mobile,
                                          "email": Defaults.Email,
                                          "gender": Defaults.Gender,
                                          "age": Defaults.AgeId,
                                          "district_id": Defaults.DistrictId,
                                          "location": Defaults.Location.address,
                                          "latitude": "\(Defaults.Latitude)",
             "longitude": "\(Defaults.Longitude)",
             "password": Defaults.Password,
             "code": Defaults.code,
             "lang": LanguageManger.shared.currentLanguage.rawValue,
             "device_id": Defaults.DeviceId,
            "provider": Defaults.SocialProvider,
            "provider_id": Defaults.SocialId,
            "provider_token": Defaults.SocialToken,
             "firebase_token": Defaults.FirebaseToken,
             "device_type":"2"]
        } else {
            parameters = ["first_name": Defaults.FirstName,
                                         "last_name": Defaults.LastName,
                                         "mobile": Defaults.Mobile,
                                         "email": Defaults.Email,
                                         "gender": Defaults.Gender,
                                         "age": Defaults.AgeId,
                                         "district_id": Defaults.DistrictId,
                                         "location": Defaults.Location.address,
                                         "latitude": "\(Defaults.Latitude)",
            "longitude": "\(Defaults.Longitude)",
            "password": Defaults.Password,
            "code": Defaults.code,
            "lang": LanguageManger.shared.currentLanguage.rawValue,
            "device_id": Defaults.DeviceId,
            "firebase_token": Defaults.FirebaseToken,
            "device_type":"2"]
        }
        
        
        
       RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: nil) { (error, data: [String:Any]?) in
                   if let error = error {
                       completion(error, nil)
                       return
                   }
                   guard let mainResponse = Mapper<RegisterResponseModel>().map(JSON: data!) else {
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
    
    func LoginSocialMedia( provider_token :String,AndSocialMediaId socialMediaId :String,AndSocialMediaType socialMediaType :String,completion: @escaping (_ errors: String?, _ data: RegisterResponseModel?) -> ()) {
        
        let url = URLs.base + "/api/customer/auth/social-login"
        let parameters:[String : Any] = ["device_type": 2, "provider_token":provider_token,"provider_id":socialMediaId,"provider":socialMediaType,"device_id":UIDevice.current.identifierForVendor!.uuidString]
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: nil) { (error, data: [String:Any]?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            guard let mainResponse = Mapper<RegisterResponseModel>().map(JSON: data!) else {
                completion("error occurred please try again later" ,nil)
                return
            }
            
            guard mainResponse.status == "1" else {
                completion( mainResponse.errs, nil)
                return
            }
            
            completion(nil, mainResponse)
        }
        
    }
       
    func socialRegisterUser(provider:String,provider_id:String,provider_token:String,completion: @escaping (_ error: String?, _ data: CustomerModel?) -> ()){
        
        let url = URLs.base + "/api/provider/social_register/add"
        let parameters:[String: Any] = ["first_name": Defaults.FirstName,
                                        "last_name": Defaults.LastName,
                                        "mobile": Defaults.Mobile,
                                        "email": Defaults.Email,
                                        "gender": Defaults.Gender,
                                        "age": Defaults.AgeId,
                                        "district_id": Defaults.DistrictId,
                                        "location": Defaults.Location.address,
                                        "latitude": "\(Defaults.Latitude)",
            "longitude": "\(Defaults.Longitude)",
            "password": Defaults.Password,
            "code": Defaults.code,
            "lang": LanguageManger.shared.currentLanguage.rawValue,
            "device_id": Defaults.DeviceId,
            "provider": provider,
            "provider_id": provider_id,
            "provider_token": provider_token,
            "firebase_token": Defaults.FirebaseToken,
            "device_type":"2"]
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: nil) { (error, data: [String:Any]?) in
            if let error = error {
                completion(error, nil)
                return
            }
            
            
            guard let data = Mapper<RegisterResponseModel>().map(JSON: data!) else {
                completion("error occurred please try again later" ,nil)
                return
            }
                       
            guard data.status == "1" else {
                completion(data.error_msg, nil)
                return
            }
            
            completion(nil, data.customer)
        
    }
}


//MARK:- LookupAll
func lookupAll(completion: @escaping (_ error: String?, _ data: LookupAllModel?) -> ()){
    let url = URLs.base + "/api/customer/auth/lookup/all"
    let headers = RequestComponent.headerComponent([.lang])
    RequestManager().request(fromUrl: url, byMethod: .post, withParameters: nil, andHeaders: headers) { (error, data: [String:Any]?) in
        if let error = error {
            completion(error, nil)
            return
        }
        guard let mainResponse = Mapper<LookupAllModel>().map(JSON: data!) else {
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
    
    //MARK:- LookUpDistrict
    func lookupDistricts(cityId: Int, completion: @escaping (_ error: String?, _ data: LookupDistrictsModel?) -> ()){
        let url = URLs.base + "/api/customer/auth/lookup/districts"
        let headers = RequestComponent.headerComponent([.lang])
        let parameters: [String: Any] = ["device_type":"2",
                                         "city_id": cityId]
          RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
                    if let error = error {
                        completion(error, nil)
                        return
                    }
                    guard let mainResponse = Mapper<LookupDistrictsModel>().map(JSON: data!) else {
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
    //////////////////////////////////////////////////////////////////////////////////
    //MARK:- Login
    func loginUser(withEmail email: String, password: String, completion: @escaping (_ error: String?, _ data: LoginResponseModel?) -> ()){
        let url = URLs.base + "/api/customer/auth/login"
        let parameters:[String: Any] = ["email": email,
                                        "password": password,
                                        "device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang])
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: [String:Any]?) in
            
            if let error = error {
                completion(error, nil)
                return
            }
            guard let mainResponse = Mapper<LoginResponseModel>().map(JSON: data!) else {
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
    
    //MARK:- refresh token
    func refreshToken(completion: @escaping (_ error: String?) -> ()){
        let url = URLs.base + "/api/customer/auth/refresh-token"
        let parameters:[String: Any] = ["device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang, .authorization])
        RequestManager().request(fromUrl: url, byMethod: HTTPMethod.post, withParameters: parameters, andHeaders: headers) { (error, data: TokenDefaultResponse?) in
            if error != nil{
                completion(error!)
                return
            }
            
            if let data = data{
                let json = JSON(data)
                let result = json.dictionaryValue
                print("result", result)
                Defaults.token = result["api_token"]?.stringValue ?? ""
                completion(nil)
                
            }else{
                completion("error occurred please try again later")
            }
            
        }
        
    }
    
    //MARK:- refresh token
    func logout(completion: @escaping (_ error: String?) -> ()){
        let url = URLs.base + "/api/customer/auth/logout"
        let parameters:[String: Any] = ["device_type": "2"]
        let headers = RequestComponent.headerComponent([.lang, .authorization])
        RequestManager().request(fromUrl: url, byMethod: HTTPMethod.post, withParameters: parameters, andHeaders: headers) { (error, data: LogoutResponse?) in
            if error != nil{
                completion(error!)
                return
            }
            
            if let data = data{
                let json = JSON(data)
                let result = json.dictionaryValue
                print("result", result)
                //Defaults.token = result["api_token"]?.stringValue ?? ""
                completion(nil)
                
            }else{
                completion("error occurred please try again later")
            }
            
        }
        
    }
}













