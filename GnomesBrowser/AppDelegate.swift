//
//  AppDelegate.swift
//  GnomesBrowser
//
//  Created by Martin on 15/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ImageCache.default.maxMemoryCost = 1024 * 1024 * 5
        coordinator = DependencyManager.shared.resolve(interface: Coordinator.self)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator?.navigationController
        window?.makeKeyAndVisible()
        coordinator?.start()

        return true
    }
}

