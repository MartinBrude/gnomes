//
//  FilterManagerTest.swift
//  GnomesBrowserTests
//
//  Created by Martin on 25/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import XCTest
@testable import GnomesBrowser

class FilterManagerTest: XCTestCase {

    func testFilterManagerInitialization() {
        let filterManager = FilterManager()
        XCTAssertNil(filterManager.savedFilter)
        XCTAssertNotNil(filterManager.memoryFilter)
    }

    func testFilterManagerConfiguration() {
        let filterManager = FilterManager()
        let ages = [1,5,4]
        let weights = [100,500,400]
        let heights = [44,66,88,99]
        filterManager.config(ages: ages, weights: weights, heights:heights)
        XCTAssert(filterManager.memoryFilter.maxAge == ages.max())
        XCTAssert(filterManager.memoryFilter.minAge == ages.min())
        XCTAssert(filterManager.memoryFilter.minWeight == weights.min())
        XCTAssert(filterManager.memoryFilter.maxWeight == weights.max())
        XCTAssert(filterManager.memoryFilter.minHeight == heights.min())
        XCTAssert(filterManager.memoryFilter.maxHeight == heights.max())
    }


    func testFilterManagerClearConfiguration() {
        let filterManager = FilterManager()
        filterManager.savedFilter = filterManager.memoryFilter
        let ages = [1,5,4]
        let weights = [100,500,400]
        let heights = [44,66,88,99]
        filterManager.config(ages: ages, weights: weights, heights:heights)
        filterManager.memoryFilter.clear()
        XCTAssert(filterManager.memoryFilter.maxAge == 0)
        XCTAssert(filterManager.memoryFilter.minAge == 0)
        XCTAssert(filterManager.memoryFilter.minWeight == 0)
        XCTAssert(filterManager.memoryFilter.maxWeight == 0)
        XCTAssert(filterManager.memoryFilter.minHeight == 0)
        XCTAssert(filterManager.memoryFilter.maxHeight == 0)
        XCTAssert(filterManager.savedFilter?.maxAge == 0)
        XCTAssert(filterManager.savedFilter?.minAge == 0)
        XCTAssert(filterManager.savedFilter?.minWeight == 0)
        XCTAssert(filterManager.savedFilter?.maxWeight == 0)
        XCTAssert(filterManager.savedFilter?.minHeight == 0)
        XCTAssert(filterManager.savedFilter?.maxHeight == 0)
    }

    func testFilterManagerApplyFilter() {
        let filterManager = FilterManager()

        let gnome1 = Gnome(city: "City", thumbnail: "", weight: 1.0, height: 2.3, id: 1, age: 140, hairColor: "Pink", professions: ["Baker"], friends: ["Pedro, Juan"], name: "Martin")
        let gnome2 = Gnome(city: "City", thumbnail: "", weight: 3.0, height: 5.3, id: 2, age: 180, hairColor: "Brown", professions: ["Tinker"], friends: ["Maria, Francisco"], name: "Pedro")
        let gnome3 = Gnome(city: "City", thumbnail: "", weight: 5.0, height: 15.3, id: 3, age: 170, hairColor: "Yellow", professions: ["Tinker"], friends: ["Maria, Francisco"], name: "Pedro")

        var gnomes = [Gnome]()
        gnomes.append(gnome1)
        gnomes.append(gnome2)
        gnomes.append(gnome3)

        let ages = gnomes.map({$0.age})
        let weigths = gnomes.map({Int($0.weight)})
        let heights = gnomes.map({Int($0.height)})

        filterManager.config(ages: ages, weights: weigths, heights: heights)
        filterManager.memoryFilter.maxAge = 150

        let result = filterManager.applyFilters(gnomes: [gnome1, gnome2, gnome3])
        XCTAssert(result.count == 1)
    }

    func testSaveFilter() {
        let filterManager = FilterManager()
        filterManager.memoryFilter.maxHeight = 10
        filterManager.saveFilter()
        XCTAssert(filterManager.savedFilter?.maxHeight == 10)
    }

    func testResetToSavedFilter() {
        let filterManager = FilterManager()
        filterManager.memoryFilter.maxHeight = 10
        filterManager.saveFilter()
        filterManager.memoryFilter.maxHeight = 20
        filterManager.resetToSavedFilter()
        XCTAssert(filterManager.savedFilter?.maxHeight == 10)
    }
}
