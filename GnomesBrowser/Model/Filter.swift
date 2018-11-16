//
//  Filter.swift
//  Alamofire
//
//  Created by Martin on 24/11/2018.
//

import Foundation

struct Filter {

    var minAge : Int
    var maxAge : Int
    var minWeight : Int
    var maxWeight : Int
    var minHeight : Int
    var maxHeight : Int
    var professions : [String]
    var friends : [String]
    var hairColor : [String]


    init(minAge : Int = 0, maxAge : Int = 0, minWeight :Int = 0, maxWeight : Int = 0, minHeight : Int = 0, maxHeight : Int = 0, professions : [String] = [String](), hairColor : [String] = [String](), friends : [String] = [String]()) {
        self.minAge = minAge
        self.maxAge = maxAge
        self.minWeight = minWeight
        self.maxWeight = maxWeight
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.professions = professions
        self.friends = friends
        self.hairColor = hairColor
    }

    mutating func clear() {
        minAge = 0
        maxAge = 0
        minWeight = 0
        maxWeight = 0
        minHeight = 0
        maxHeight = 0
        professions = [String]()
        friends = [String]()
        hairColor = [String]()
    }
}
