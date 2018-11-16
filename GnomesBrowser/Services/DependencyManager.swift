//
//  DependencyManager.swift
//  Placeholder
//
//  Created by Martin on 11/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import UIKit
import Foundation
import Swinject
import SwinjectStoryboard

public class DependencyManager {

    lazy var container: Container = {
        let container = Container()
        container.register(GnomesServiceProtocol.self) { _ in GnomesService() }.inObjectScope(.weak)
        container.register(RequestServiceProtocol.self) { _ in RequestService() }.inObjectScope(.weak)
        container.register(UINavigationController.self) { _ in
            let navigationController = UINavigationController()
            navigationController.navigationBar.barTintColor = UIColor.primaryColor
            let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            navigationController.navigationBar.titleTextAttributes = textAttributes
            return navigationController
            }.inObjectScope(.weak)

        container.register(Coordinator.self) {
            _ in MainCoordinator(navigationController : DependencyManager.shared.resolve(interface: UINavigationController.self))
            }.inObjectScope(.weak)
        container.storyboardInitCompleted(GnomesViewController.self) { r, c in }
        container.register(FilterManager.self) { _ in FilterManager() }.inObjectScope(.container)

        return container
    }()


    static let shared = DependencyManager()

    func resolve<T>(interface: T.Type) -> T! {
        return container.resolve(interface)
    }

    private init() {}
}

extension DependencyManager {

    static func resolve<T>(interface: T.Type) -> T! {
        return DependencyManager.shared.resolve(interface: interface)
    }
}
