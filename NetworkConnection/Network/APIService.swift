//
//  APIService.swift
//  networkConnection
//
//  Created by Алина Кошманова on 15.01.2020.
//  Copyright © 2020 Алина Кошманова. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    //MARK: - Constants
    final let baseUrl = "http://api.rottentomatoes.com"
    final let apiPrefix = "api/public"
    final let apiVersion = "v1.0"
    
    
    //MARK: - Functions
    
    func get(path: String, parameters: [String:Any]?, success: @escaping (DataResponse<Any>) -> Void, failure: @escaping (Int, String, DataResponse<Any>) -> Void) {
        
        let urlString = String.init(format: "%@/%@/%@/%@", baseUrl, apiPrefix, apiVersion, path)
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            let statusCode = response.response?.statusCode ?? 0
            if statusCode == 200 {
                success(response)
            } else {
                failure(statusCode, self.errorMessageFor(statusCode: statusCode), response)
            }
            
        }
    }
    
    func get(path: String, success: @escaping (DataResponse<Any>) -> Void, failure: @escaping (Int, String, DataResponse<Any>) -> Void) {
        self.get(path: path, parameters: nil, success: success, failure: failure)
    }
    
    func post(path: String, parameters: [String:Any]?, success: @escaping (DataResponse<Any>) -> Void, failure: @escaping (Int, String, DataResponse<Any>) -> Void) {
        
        let urlString = String.init(format: "%@/%@/%@/%@", baseUrl, apiPrefix, apiVersion, path)
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            let statusCode = response.response?.statusCode ?? 0
            if statusCode == 200 {
                success(response)
            } else {
                failure(statusCode, self.errorMessageFor(statusCode: statusCode), response)
            }
            
        }
    }
    
    func post(path: String, success: @escaping (DataResponse<Any>) -> Void, failure: @escaping (Int, String, DataResponse<Any>) -> Void) {
        self.post(path: path, parameters: nil, success: success, failure: failure)
    }
    
    
    //MARK: - Private functions
    
    private func errorMessageFor(statusCode: Int) -> String {
        
        switch statusCode {
        case 401:
            return String.NetworkError.error401
        case 404:
            return String.NetworkError.error404
        case 500:
            return String.NetworkError.error500
        case 503:
            return String.NetworkError.error503
        default:
            if NetworkReachabilityManager()?.isReachable ?? false {
                return String.NetworkError.standart
            } else {
                return String.NetworkError.unreachable
            }
        }
    }
    
}
