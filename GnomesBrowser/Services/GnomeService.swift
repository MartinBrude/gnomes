//
//  GnomeServiceProtocol.swift
//  GnomesBrowser
//
//  Created by Martin on 19/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import Foundation

protocol GnomesServiceProtocol {
    func fetchGnomes(successful: @escaping ([Gnome]) -> (), failure: @escaping (String?) -> ())
}

class GnomesService : GnomesServiceProtocol {

    private var requestService = DependencyManager.shared.resolve(interface: RequestServiceProtocol.self)

    func fetchGnomes(successful: @escaping ([Gnome]) -> (), failure: @escaping (String?) -> ()) {
        _ = requestService?.get(path: NetworkingConstants.baseUrl, complete: { (response) in
            var gnomesToReturn = [Gnome]()
            if let gnomesByCity = JSONParser.parseGnomes(response: response) {
                for (city, gnomes) in gnomesByCity {
                    for var gnome in gnomes {
                        gnome.city = city
                        gnomesToReturn.append(gnome)
                    }
                }
            }
            successful(gnomesToReturn)
        }, failure: { (error) in
            if let errorMessage = error as? String {
                failure(errorMessage)
            }
        })
    }
}
