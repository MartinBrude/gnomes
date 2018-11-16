//
//  JsonDecoderExtension.swift
//  Placeholder
//
//  Created by Martin on 12/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import Foundation
import Alamofire

extension JSONDecoder {
    func decodeMapResponse<T: Decodable>(from response: DataResponse<Any>) -> Result<[String:[T]]> {
        guard response.error == nil else {
            return .failure(response.error!)
        }

        guard let responseData = response.data else {
            return .failure(BackendError.parsing(reason:"Did not get data in response"))
        }

        do {
            let item = try decode([String:[T]].self, from: responseData)
            return .success(item)
        } catch {
            return .failure(error)
        }
    }
}

class BackendError {
    static func parsing(reason : String) -> Error {
        return NSError(domain: reason, code: 0, userInfo: nil)
    }
}
