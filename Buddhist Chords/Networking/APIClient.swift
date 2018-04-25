//
//  APIClient.swift
//  ApiBuilder
//
//  Created by Viet Nguyen Tran on 4/2/18.
//  Copyright © 2018 ios simple. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

protocol APIClient {
    static var rootURL: String { get }
}

extension APIClient {
    static var rootURL: String {
        return "https://pvsongs.com/api"
    }
    
    static func dataRequest<T: Decodable>(path: String,
                                          method: HTTPMethod = .get,
                                          params: Parameters? = nil,
                                          encoding: ParameterEncoding = URLEncoding.default,
                                          headers: HTTPHeaders? = nil) -> Promise<T> {
        return Alamofire.request(rootURL + path,
                                 method: method,
                                 parameters: params,
                                 encoding: encoding,
                                 headers: headers)
            .responseDecodable()
    }
}
