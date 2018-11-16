//
//  GnomesBrowserTests.swift
//  GnomesBrowserTests
//
//  Created by Martin on 24/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import XCTest
import SwinjectStoryboard
@testable import GnomesBrowser

class FilterViewControllerTest: XCTestCase {

    var filterViewController : FilterViewController?

    func stubbedGnomes() -> [Gnome] {
        var gnomes = [Gnome]()
        let gnome1 = Gnome(city: "Barcelona", thumbnail: "http://www.google.es", weight: 10.4, height: 120.0, id: 1, age: 1001, hairColor: "Pink", professions: ["Baker"], friends: ["Santiago"], name: "Pedro")

        let gnome2 = Gnome(city: "Buenos Aires", thumbnail: "http://www.google.es", weight: 10.4, height: 120.0, id: 1, age: 1002, hairColor: "Pink", professions: ["Baker"], friends: ["Santiago"], name: "Pedro")

        let gnome3 = Gnome(city: "Montevideo", thumbnail: "http://www.google.es", weight: 10.4, height: 120.0, id: 1, age: 1003, hairColor: "Pink", professions: ["Baker"], friends: ["Santiago"], name: "Pedro")
        gnomes.append(gnome1)
        gnomes.append(gnome2)
        gnomes.append(gnome3)

        return gnomes
    }

    override func setUp() {

        let storyboard = SwinjectStoryboard.create(name: Storyboards.Main, bundle: nil, container: DependencyManager.shared.container)
        if let filterViewController = storyboard.instantiateViewController(withIdentifier: Scenes.Filters) as? FilterViewController {
            filterViewController.coordinator = DependencyManager.shared.resolve(interface: Coordinator.self)
            filterViewController.filterManager = DependencyManager.shared.resolve(interface: FilterManager.self)
            self.filterViewController = filterViewController
        }
        self.filterViewController?.loadViewIfNeeded()
    }

    override func tearDown() {
        self.filterViewController = nil
    }

    func testFilterViewControllerExists() {
        XCTAssertNotNil(filterViewController, "Controller should be not nil")
        XCTAssertNotNil(filterViewController?.ageSlider, "Slider should be not nil")
        XCTAssertNotNil(filterViewController?.heightSlider, "Slider should be not nil")
        XCTAssertNotNil(filterViewController?.weightSlider, "Slider should be not nil")
        XCTAssertNotNil(filterViewController?.friendsButton, "Button should be not nil")
        XCTAssertNotNil(filterViewController?.professionsButton, "Button should be not nil")
        XCTAssertNotNil(filterViewController?.hairColorButton, "Button should be not nil")
    }
}
