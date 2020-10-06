//
//  RequestComponent.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/25/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RequestManager {
     func request(fromUrl url: String, byMethod method: HTTPMethod, withParameters parameters: [String:Any]?
            , andHeaders headers: HTTPHeaders?, completion:   @escaping ( _ error: String?,_ response:[String:Any]?) -> ()) {
            print("✊ \(method) With URL:  \(url)")
            
            
         AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                           print("**MD** url: " + url)
                           //print(parameters!)
                           //print()
                           let code  = response.response?.statusCode
                           print("**MD** response: \(response)")
                           switch response.result{
                           case .success(let value):
                               let valJsonBlock =  value as! [String : Any]
                                                     
                               if code! == 200 || code! == 201 {
                                   // 200 success in general , 201 success for signUp
    //                            self.handleSuccess(response: response, completion: completion)
                                completion(nil,valJsonBlock)
                               }
                               else
                               {
                                
                                if code == 400 {
                                   //invalid url: your sent a request that this server could not understand.
    //                                self.handleError(response: response, completion: completion)
                                    completion(valJsonBlock["error_msg"] as? String,nil )
                                   
                               }else if code == 401 {
                                   //Unauthorized error: the page you were trying to access cannot be loaded until you first log in with a valid user ID and password
    //                                completion([:],valJsonBlock["error"] as? String )
    //                                Router().toAuthenticationNavigator()
                                    // the new updates below
    //                                self.handleTokenExpired(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers, response: response, completion: completion)
                                     completion(valJsonBlock["error_msg"] as? String,nil )
                               }else if code == 426 {
    //                                 completion([:],valJsonBlock["error"] as? String )
                                    // the new updates below
    //                             self.handleUpgradeRequired(response: response, completion: completion)
                                     completion(valJsonBlock["error_msg"] as? String,nil )
                               }else if code == 404 {
    //                                 self.handleErrors(response: response, completion: completion)
                                } else {
                                    completion("error occured with code: \(code ?? -1), please try again later", nil)
                                }
                    }
                           case .failure(let error):
                                print("😡 Failure \(error.localizedDescription)")
                                completion(error.localizedDescription, nil)
                           }
                   }
                
        }
    func request<T: Decodable>(fromUrl url: String, byMethod method: HTTPMethod, withParameters parameters: [String:Any]?
        , andHeaders headers: HTTPHeaders?, completion: @escaping (_ error: String?, T?) -> ()) {
        print("**MD** ✊ \(method) With URL:  \(url) with paramters \(parameters)")
        
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                print("**MD** url: " + url)
                //print(parameters!)
                //print()
                let code  = response.response?.statusCode
                print("**MD** response: \(response)")
                switch response.result{
                case .success(_):
                    
                    if code == 200 || code == 201{
                        // 200 success in general , 201 success for signUp
//                        self.handleSuccess(response: response, completion: completion)
                        
                    }else if code == 400 {
                        //invalid url: your sent a request that this server could not understand.
                        self.handleError(response: response, completion: completion)
                        
                    }else if code == 401 {
                        //Unauthorized error: the page you were trying to access cannot be loaded until you first log in with a valid user ID and password
//                        self.handleTokenExpired(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers, response: response, completion: completion)
                        
                    }else if code == 426 {
                        self.handleUpgradeRequired(response: response, completion: completion)
                        
                    }else{
                        completion("error occured with code: \(code ?? -1), please try again later", nil)
                    }
                    
                case .failure(let error):
                    print("**MD** 😡 Failure \(error.localizedDescription)")
                    completion(error.localizedDescription, nil)
                }
        }
    }
 /*   func requestMappable(fromUrl url: String, byMethod method: HTTPMethod, withParameters parameters: [String:Any]?
        , andHeaders headers: [String: String]?, completion: @escaping (_ error: String?, [String:Any]?) -> ()) {
        print("**MD** ✊ \(method) With URL:  \(url) with paramters \(parameters)")
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                print("**MD** url: " + url)
                //print(parameters!)
                //print()
                let code  = response.response?.statusCode
                print("**MD** response: \(response)")
                switch response.result{
                 case .success(let value):
                                  let valJsonBlock =  value as! [String : Any]
                                  
                                  if code == 200 || code == 201{
                                      // 200 success in general , 201 success for signUp
                                      completion(nil,valJsonBlock)
                                      
                                  }else if code == 400 {
                                      //invalid url: your sent a request that this server could not understand.
                                     completion(valJsonBlock["error_msg"] as? String ,[:] )
                                      
                                      
                                  }else if code == 401 {
                                      //Unauthorized error: the page you were trying to access cannot be loaded until you first log in with a valid user ID and password
                                       completion(valJsonBlock["error_msg"] as? String ,[:] )
                                      
                                  }else if code == 426 {
                                     // self.handleUpgradeRequired(response: response, completion: completion)
                                      
                                  }else{
                                      completion("error occured with code: \(code ?? -1), please try again later", nil)
                                  }
                                  
                              case .failure(let error):
                                  print("**MD** 😡 Failure \(error.localizedDescription)")
                                  completion(error.localizedDescription, nil)
                              }
        }
    }*/
    /*
    private func handleSuccess<T: Decodable>(response: DataResponse<Any>, completion: @escaping (_ error: String?, T?) -> ()) {
        
        guard let _data = response.data else {
            completion("error occured while handling data, please try again later",nil)
            return
        }
        
        do{
            
            let data = try JSONDecoder().decode(T.self, from: _data)
            print(data)
            completion(nil, data)
            
        } catch{
            
            
            print("----------------")
            print(error)
            completion("error in decoding, please try again later",nil)
        }
    }
    */
    private func handleTokenExpired(fromUrl url: String, byMethod method: HTTPMethod, withParameters parameters: [String:Any]?, andHeaders headers: HTTPHeaders?,response: AFDataResponse<Any>, completion: @escaping ( _ error: String?,_ response:[String:Any]?) -> ()) {
        
           if let _ = response.data{

                      let lastUrl = url
                      let lastMethod = method
                      let lastParameters = parameters
                      var lastHeaders = headers

                      // call refresh token service and then recall the APi that is already exist.
                      self.refreshToken(completion: { (error) in
                          if let error = error {
                              completion(error, nil)

                          } else {
                              lastHeaders?["Authorization"] = "Bearer " + Defaults.token
                              RequestManager().request(fromUrl: lastUrl, byMethod: lastMethod, withParameters: lastParameters, andHeaders: lastHeaders, completion: { (newError, newData: [String:Any]?) in
                                  if let _newError = newError {
                                      completion(_newError, nil)

                                  } else {
                                      completion(nil, newData)
                                  }
                              })
                          }
                      })
                  } else {
                      completion("unexpected error occures , please try again later.", nil)
                  }
       }
       /*
    private func handleTokenExpired<T: Decodable>(fromUrl url: String, byMethod method: HTTPMethod, withParameters parameters: [String:Any]?, andHeaders headers: [String: String]?,response: DataResponse<Any>, completion: @escaping (_ error: String?, T?) -> ()) {
        
        // this codes is handled when the API have a token
        if let _ = response.data{
            completion("token expired", nil)
            Defaults.token = "not yet"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
               Router().toAuthenticationVC() // call your functin here
            }
            
//            let lastUrl = url
//            let lastMethod = method
//            let lastParameters = parameters
//            var lastHeaders = headers
            
            // call refresh token service and then recall the APi that is already exist.
//            self.refreshToken(completion: { (error) in
//                if let error = error{
//                    completion(error, nil)
//                }else{
//                    lastHeaders?["Authorization"] = "Bearer " + Defaults.token
//                    RequestManager().request(fromUrl: lastUrl, byMethod: lastMethod, withParameters: lastParameters, andHeaders: lastHeaders, completion: { (newError, newData: T?) in
//                        if let _newError = newError{
//                            completion(_newError, nil)
//
//                        }else{
//                            completion(nil, newData)
//                        }
//                    })
//                }
//
//            })
        }else{
            completion("unexpected error occures , please try again later.", nil)
        }
        }
        */
        private func handleUpgradeRequired<T: Decodable>(response: AFDataResponse<Any>, completion: @escaping (_ error: String?, T?) -> ()) {
            completion("Upgrade Required", nil)
        }
        
        private func handleError<T: Decodable>(response: AFDataResponse<Any>, completion: @escaping (_ error: String?, T?) -> ()) {
            // error occured is here
            if let _ = response.data{
                completion("", nil)
            }
        }
    
    private func handleErrors<T: Decodable>(response: AFDataResponse<Any>, completion: @escaping (_ error: String?, T?) -> ()) {
        // errors occured is here
//        guard let _data = response.data else {
//            completion("error occured while handling data, please try again later",nil)
//            return
//        }
//
//        do{
//
//            let data = try JSONDecoder().decode(DefaultResponse.self, from: _data)
//
//            var theError = ""
//            for error in data.errors{
//                theError += "\(error.value) \n"
//            }
//
//            completion(theError, nil)
//        } catch{
//            print("----------------")
//            print(error)
//            completion("error in decoding, please try again later",nil)
//        }
    }
    
    
    private func refreshToken(completion: @escaping (_ error: String?) -> ()){
        
        let url = URLs.base + "/api/customer/auth/refresh-token"
        let parameters: [String: Any] = ["device_type": "2",
                                         "device_id": Defaults.DeviceId]
        let headers = RequestComponent.headerComponent([.lang, .authorization])
        
        RequestManager().request(fromUrl: url, byMethod: .post, withParameters: parameters, andHeaders: headers) { (error, data: RegisterResponse?) in
            if error != nil{
                completion(error!)
                return
            }
            if let data = data{
                Defaults.token = data.customer?.api_token ?? ""
                completion(nil)
            }else{
                completion("error occurred please try again later")
            }
        }
    }
        
}















































