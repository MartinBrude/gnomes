//
//  GnomeTest.swift
//  GnomesBrowserTests
//
//  Created by Martin on 25/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import XCTest
@testable import GnomesBrowser

class GnomeTest: XCTestCase {

    func testGnomeModel() {
        let gnome = Gnome(city: "Barcelona", thumbnail: "http://www.google.es", weight: 10.4, height: 120.0, id: 1, age: 1000, hairColor: "Pink", professions: ["Baker"], friends: ["Santiago"], name: "Pedro")
        XCTAssert(gnome.age == 1000)
        XCTAssert(gnome.city == "Barcelona")
        XCTAssert(gnome.thumbnail == "http://www.google.es")
        XCTAssert(gnome.weight == 10.4)
        XCTAssert(gnome.height == 120.0)
        XCTAssert(gnome.hairColor == "Pink")
    }
}
