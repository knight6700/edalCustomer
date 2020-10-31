//
//  File.swift
//  Edal
//
//  Created by Mahmoud Fares on 12/2/19.
//  Copyright © 2019 Mahmoud Fares. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient {
    @discardableResult
    private static func performRequest<T: Decodable>(route: EndPoints, completion:@escaping (T?, Error?,Int?) -> Void) -> DataRequest {
        
        return AF.request(route).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                    print(value)
                do {
                    let DataResponsed = try JSONDecoder().decode(T.self, from: response.data!)
                    completion(DataResponsed, nil, response.response?.statusCode)
                } catch {
                    print(error)
                    completion(nil, error,response.response?.statusCode)
                }
            case .failure(let error):
                print(error)
                completion(nil, error, response.response?.statusCode)
            }
        }
        ) }
    // func Generic post // get
    static func CallApi<T: Decodable> (endPoint: EndPoints, completion:@escaping (HandleResponse<T>)  ) {
        performRequest(route: endPoint) { (results, error,code) in
            completion(results, error,code ?? 1001 )
        }
    }
    
    static func checkErrors <T: Decodable>(error: String?, errorSubCategories: String?, completion: @escaping ( _ error: String?,  _ subserviceInfoResponse: T?) -> Void) {
        guard error == nil else {
            completion(error,nil)
            return
        }
        guard errorSubCategories == nil else {
            completion(errorSubCategories,nil)
            return
        }
    }
    
    
    
}
extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}

