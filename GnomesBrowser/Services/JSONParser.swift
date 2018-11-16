//
//  JSONParser.swift
//  Placeholder
//
//  Created by Martin on 12/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import Foundation
import Alamofire

class JSONParser {
    static func parseGnomes(response : DataResponse<Any>) -> [String:[Gnome]]? {
        let gnomesResult : Result<[String:[Gnome]]> = JSONDecoder().decodeMapResponse(from: response)
        return gnomesResult.value
    }
}

