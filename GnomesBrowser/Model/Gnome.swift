//
//  Gnome.swift
//  GnomesBrowser
//
//  Created by Martin on 25/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import Foundation

struct Gnome : Codable {

    var city : String?
    var thumbnail : String
    var weight : Float
    var height : Float
    var id : Int
    var age : Int
    var hairColor : String
    var professions : [String]
    var friends : [String]
    var name : String

    enum CodingKeys : String, CodingKey {

        case thumbnail = "thumbnail"
        case weight = "weight"
        case height = "height"
        case id = "id"
        case age = "age"
        case hairColor = "hair_color"
        case professions = "professions"
        case friends = "friends"
        case name = "name"
    }
}
