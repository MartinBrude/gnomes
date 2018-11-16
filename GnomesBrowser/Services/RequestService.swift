//
//  RequestService.swift
//  Placeholder
//
//  Created by Martin on 11/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import UIKit
import Alamofire

protocol RequestServiceProtocol {
    func get(path: String, complete: @escaping (DataResponse<Any>) -> (), failure: @escaping (Any?) -> ()) -> DataRequest?
}

class RequestService : RequestServiceProtocol {

    @discardableResult
    func get(path: String, complete: @escaping (DataResponse<Any>) -> (), failure: @escaping (Any?) -> ()) -> DataRequest? {
        return request(method: .get, path: path, complete: complete, failure: failure)
    }

    private func request(method : HTTPMethod, path: String, complete: @escaping (DataResponse<Any>) -> (), failure: @escaping (Any?) -> ()) -> DataRequest? {
        return request(baseUrl: NetworkingConstants.baseUrl, method: method, path: path, complete: complete, failure: failure)
    }

    private func request(baseUrl : String ,method : HTTPMethod, path: String?, complete: @escaping (DataResponse<Any>) -> (), failure: @escaping (Any?) -> ()) -> DataRequest? {
        if !Connectivity.isConnectedToInternet() {
            failure("There is no internet connection available.")
            return nil
        }

        return Alamofire.request(baseUrl, method: method, parameters: nil, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["text/plain"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    complete(response)
                case .failure(_):
                    failure(response)
                }
        }
    }
}

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
