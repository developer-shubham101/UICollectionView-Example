//
//  NetworkManager.swift
//  Currency Converter
//
//  Created by Amit Shukla on 22/12/17.
//  Copyright © 2017 Amit Shukla. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    static let PROTOCOL: String = "https://";
    static let SUB_DOMAIN: String = "";
     
    static let DOMAIN: String = "reqres.in/";
    static let API_DIR: String = "api/";
    
    static let SITE_URL = PROTOCOL + SUB_DOMAIN + DOMAIN;
    static let API_URL = SITE_URL + API_DIR;
     
       
    static func getUserList(page: Int, limit: Int, completion: @escaping (Bool, Any) -> Void) {
        NetworkManager.callService(url: "\(API_URL)users?page=\(page)&per_page=\(limit)")  { (success, response) in
            completion(success, response)
        }
    }
	
	static func callService(url:String, completion:@escaping (Bool, Any) -> Void){
       
        Alamofire.request(url, method:.get).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result.value)")                   // response serialization result
            
            
            guard response.result.isSuccess else {
                completion(true, "Something went wrong!!")
                print("Error while fetching json: \(String(describing: response.result.error))")
                return
            }
            guard let responseJSON = response.result.value as? [String: Any] else {
                completion(true, "Something went wrong!!")
                print("invalid json recieved from server: \(String(describing: response.result.error))")
                return
            }
            
            if response.response?.statusCode == 200 {
                completion(true, responseJSON)
            }else{
                completion(true, "Something went wrong!!")
            }
        }
    }
}
