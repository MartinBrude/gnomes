//
//  DependencyManagerTest.swift
//
//  Created by Martin on 17/10/2018.
//  Copyright © 2018 M. All rights reserved.
//

import XCTest
import SwinjectStoryboard
@testable import GnomesBrowser

class DependencyManagerTest: XCTestCase {

    func testDependencyInjector() {
        let storyboard = SwinjectStoryboard.create(name: Storyboards.Main, bundle: nil, container: DependencyManager.shared.container)
        if let viewController = storyboard.instantiateViewController(withIdentifier: Scenes.Gnomes) as? GnomesViewController {
            viewController.coordinator = DependencyManager.shared.resolve(interface: Coordinator.self)
            viewController.service = DependencyManager.resolve(interface: GnomesServiceProtocol.self)
            XCTAssertNotNil(viewController.service)
            XCTAssertNotNil(viewController.coordinator)
        }
    }
}


