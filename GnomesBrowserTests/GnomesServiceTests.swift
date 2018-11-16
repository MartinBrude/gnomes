//
//  GnomesBrowserTests.swift
//  GnomesBrowserTests
//
//  Created by Martin on 24/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import XCTest
@testable import GnomesBrowser

class FakeSuccessGnomeService : GnomesServiceProtocol {
    var didCallFakeGnomeService = false
    func fetchGnomes(successful: @escaping ([Gnome]) -> (), failure: @escaping (String?) -> ()) {
        didCallFakeGnomeService = true
        let gnome = Gnome(city: "Barcelona", thumbnail: "https://www.someurl.cat", weight: 50, height: 50, id: 1, age: 190, hairColor: "Pink", professions: ["Baker"], friends: ["Other Gnome"], name: "Peter")
        successful([gnome])
    }
}

class FakeFailedGnomeService : GnomesServiceProtocol {
    var didCallFakeGnomeService = false
    func fetchGnomes(successful: @escaping ([Gnome]) -> (), failure: @escaping (String?) -> ()) {
        didCallFakeGnomeService = true
        failure("Something went wrong")
    }
}

class GnomesServiceTests: XCTestCase {

    var serviceSuccess: FakeSuccessGnomeService?
    var serviceFailed: FakeSuccessGnomeService?

    override func setUp() {
        serviceSuccess = FakeSuccessGnomeService()
    }

    override func tearDown() {
        serviceSuccess = nil
    }

    func testServiceSuccess() {
        serviceSuccess?.fetchGnomes(successful: { (gnomes) in
            XCTAssert(gnomes.count == 1)
        }, failure: { (failure) in })
        XCTAssert(serviceSuccess?.didCallFakeGnomeService == true)
    }

    func testServiceFails() {
        serviceSuccess?.fetchGnomes(successful: { (gnomes) in
        }, failure: { (failure) in
            XCTAssertNotNil(failure)
        })
        XCTAssert(serviceSuccess?.didCallFakeGnomeService == true)
    }
}
