//
//  GetPhoneNumberCodeAPI.swift
//  CarFluent
//
//  Created by mac on 12/1/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import Foundation
import Alamofire

class GetPhoneNumberCodeAPI {
    
    static var shared = GetPhoneNumberCodeAPI()
    
    func phoneNumberCode(completion: @escaping (_ data: [String]) -> Void) {
        let BaseURL = "https://restcountries.eu/rest/v2/all/"
        let postURL = BaseURL
        let parameters: [String: Any] = [:]
        let headers: HTTPHeaders = [:]
        let method: HTTPMethod = .get
        var numberPhone: [String] = []
        guard let url = URL.init(string: postURL) else { return }
        AF.request(url, method: method, parameters: parameters, headers: headers).validate().responseData { (respnose) in
            switch respnose.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<String, Any>]
                    for item in json ?? [] {
                        let obj = (item["callingCodes"] as? [String])?.first ?? ""
                        if obj != "" {
                            numberPhone.append("+\(obj)")
                        }
                    }
                } catch(let error) {
                    debugPrint(error.localizedDescription)
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                break
            }
            completion(numberPhone)
        }
    }
    
}
