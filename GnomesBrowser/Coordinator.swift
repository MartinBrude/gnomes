//
//  Coordinator.swift
//  Placeholder
//
//  Created by Martin on 12/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SwinjectStoryboard

protocol Coordinator : class {
    var navigationController: UINavigationController { get set }
    func start()
    func presentFilters(gnomes : [Gnome]?, delegate : FilterControllerDelegate)
    func showMultipleSelectionFilter(from viewController : UIViewController, items : [String], delegate : MultipleOptionsDelegate, chosenAttributes : [String], type : MultipleSelectionType)
}

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController
    private var storyboard = SwinjectStoryboard.create(name: Storyboards.Main, bundle: nil, container: DependencyManager.shared.container)

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if let viewController = storyboard.instantiateViewController(withIdentifier: Scenes.Gnomes) as? GnomesViewController {
            viewController.coordinator = self
            viewController.service = DependencyManager.resolve(interface: GnomesServiceProtocol.self)
            navigationController.pushViewController(viewController, animated: true)
        }
    }

    func showMultipleSelectionFilter(from viewController : UIViewController, items : [String], delegate : MultipleOptionsDelegate, chosenAttributes : [String], type : MultipleSelectionType) {
        if let multipleSelection = storyboard.instantiateViewController(withIdentifier: Scenes.MultipleSelection) as? MultipleSelectionViewController {
            multipleSelection.type = type
            multipleSelection.title = type.rawValue
            multipleSelection.delegate = delegate
            multipleSelection.items = items.map({ Item(text : $0, isSelected : chosenAttributes.contains($0)) })
            navigationController.pushViewController(multipleSelection, animated: true)
        }
    }

    func presentFilters(gnomes : [Gnome]?, delegate : FilterControllerDelegate) {
        if let filterViewController = storyboard.instantiateViewController(withIdentifier: Scenes.Filters) as? FilterViewController {
            filterViewController.filterManager = DependencyManager.shared.resolve(interface: FilterManager.self)
            filterViewController.gnomes = gnomes
            filterViewController.delegate = delegate
            filterViewController.coordinator = self
            navigationController.pushViewController(filterViewController, animated: true)
        }
    }
}
