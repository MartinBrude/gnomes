//
//  Constants.swift
//  Placeholder
//
//  Created by Martin on 11/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import Foundation

struct NetworkingConstants {
    private init () { }
    static let baseUrl = Bundle.main.infoDictionary?["gnomesAPI"] as! String
}

struct Storyboards {
    private init() {}
    static let Main = "Main"
}

struct Scenes {
    private init() {}
    static let Filters = "FilterViewController"
    static let Gnomes = "GnomesViewController"
    static let MultipleSelection = "MultipleSelection"
}
