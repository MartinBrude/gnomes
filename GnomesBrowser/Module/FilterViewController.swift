//
//  FilterViewController.swift
//  GnomesBrowser
//
//  Created by Martin on 16/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import UIKit
import ZMSwiftRangeSlider
import SwinjectStoryboard

protocol FilterControllerDelegate : class {
    func didSaveFilters(gnomes : [Gnome])
}

class FilterViewController: UIViewController {

    @IBOutlet weak var hairColorButton: UIButton!
    @IBOutlet weak var friendsButton: UIButton!
    @IBOutlet weak var professionsButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var ageSlider : FilterRangeSlider!
    @IBOutlet weak var weightSlider : FilterRangeSlider!
    @IBOutlet weak var heightSlider : FilterRangeSlider!

    var goingForward : Bool = true
    weak var delegate: FilterControllerDelegate?
    weak var coordinator : Coordinator?
    var filterManager : FilterManager!
    private var filtered : [Gnome]?
    var gnomes : [Gnome]? {
        didSet {
            configFilterManager()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear all", style: .plain, target: self, action: #selector(clearAll))
        setupFilters()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if goingForward {
            filterManager.resetToSavedFilter()
            applyFilters()
        }
    }

    func configFilterManager() {
        if let ages = gnomes?.map({$0.age}), let weigths = gnomes?.map({Int($0.weight)}), let heights = gnomes?.map({Int($0.height)}) {
            filterManager.config(ages: ages, weights: weigths, heights: heights)
        }
    }

    private func resetMultipleOptionsLists() {
        let emptyList = [String]()
        didSelectOptions(options: emptyList, filter: MultipleSelectionType.Friends.rawValue)
        didSelectOptions(options: emptyList, filter: MultipleSelectionType.Professions.rawValue)
        didSelectOptions(options: emptyList, filter: MultipleSelectionType.HairColor.rawValue)
    }

    @objc func clearAll() {
        filtered = gnomes
        filterManager.savedFilter = nil
        resetMultipleOptionsLists()
        configFilterManager()
        setupFilters()
        applyFilters()
    }

    func applyFilters() {
        guard let gnomes = gnomes else { return }
        filtered = filterManager.applyFilters(gnomes: gnomes)
        saveButton.setTitle("Save (\(filtered!.count))", for: .normal)
    }

    @IBAction func professionsButtonPressed(_ sender: UIButton) {
        if let attributes = gnomes?.compactMap({$0.professions}).joined() {
            presentAttributesFilter(attributes: Array(attributes), chosenAttributes: filterManager.memoryFilter.professions, type: MultipleSelectionType.Professions)
        }
    }

    @IBAction func friendsButtonPressed(_ sender: UIButton) {
        if let attributes = gnomes?.compactMap({$0.friends}).joined() {
            presentAttributesFilter(attributes: Array(attributes), chosenAttributes: filterManager.memoryFilter.friends, type: MultipleSelectionType.Friends)
        }
    }

    @IBAction func hairColorsBuuttonPressed(_ sender: UIButton) {
        if let attributes = gnomes?.compactMap({$0.hairColor}) {
            presentAttributesFilter(attributes: attributes, chosenAttributes: filterManager.memoryFilter.hairColor, type: MultipleSelectionType.HairColor)
        }
    }

    private func presentAttributesFilter(attributes :  [String], chosenAttributes : [String]?, type : MultipleSelectionType) {
        var attributes = attributes
        attributes.removeDuplicates()
        attributes = attributes.sorted { $0 < $1 }
        goingForward = false
        coordinator?.showMultipleSelectionFilter(from : self, items : attributes, delegate: self, chosenAttributes : chosenAttributes ?? [String](), type : type)
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let filtered = filtered else { return }
        filterManager.saveFilter()
        delegate?.didSaveFilters(gnomes: filtered)
        goingForward = false
        coordinator?.navigationController.popViewController(animated: true)
    }
}

extension FilterViewController {

    private func setupFilters() {
        setupAgeFilter()
        setupHeightFilter()
        setupWeightFilter()
        setupMultipleOptionsFilter()
    }

    private func setupAgeFilter() {
        let ages = gnomes?.map({$0.age})
        let minAge = ages?.min() ?? 0
        let maxAge = ages?.max() ?? 0
        ageSlider.config(minRangeValue: minAge, maxRangeValue: maxAge, currentMinValue: filterManager.memoryFilter.minAge, currentMaxValue: filterManager.memoryFilter.maxAge)
        ageSlider.setValueChangedCallback { [weak self] (min, max) in
            self?.filterManager?.memoryFilter.minAge = min
            self?.filterManager?.memoryFilter.maxAge = max
            self?.applyFilters()
        }
    }

    private func setupHeightFilter() {
        let heights = gnomes?.map({$0.height})
        let minHeight = heights?.min() ?? 0
        let maxHeight = heights?.max() ?? 0
        heightSlider.config(minRangeValue: Int(minHeight), maxRangeValue: Int(maxHeight), currentMinValue: filterManager.memoryFilter.minHeight, currentMaxValue: filterManager.memoryFilter.maxHeight)
        heightSlider.setValueChangedCallback { [weak self] (min, max) in
            self?.filterManager?.memoryFilter.minHeight = min
            self?.filterManager?.memoryFilter.maxHeight = max
            self?.applyFilters()
        }
    }

    private func setupWeightFilter() {
        let weights = gnomes?.map({$0.weight})
        let minWeight = weights?.min() ?? 0
        let maxWeight = weights?.max() ?? 0
        weightSlider.config(minRangeValue: Int(minWeight), maxRangeValue: Int(maxWeight), currentMinValue: filterManager.memoryFilter.minWeight, currentMaxValue: filterManager.memoryFilter.maxWeight)
        weightSlider.setValueChangedCallback { [weak self] (min, max) in
            self?.filterManager?.memoryFilter.minWeight = min
            self?.filterManager?.memoryFilter.maxWeight = max
            self?.applyFilters()
        }
    }

    private func setupMultipleOptionsFilter() {
        if let professions = filterManager.savedFilter?.professions {
            didSelectOptions(options: professions, filter: MultipleSelectionType.Professions.rawValue)
        }

        if let hairColors = filterManager.savedFilter?.hairColor {
            didSelectOptions(options: hairColors, filter: MultipleSelectionType.HairColor.rawValue)
        }

        if let friends = filterManager.savedFilter?.friends {
            didSelectOptions(options: friends, filter: MultipleSelectionType.Friends.rawValue)
        }
    }

}

extension FilterViewController : MultipleOptionsDelegate {
    func didSelectOptions(options: [String], filter : String) {
        switch filter {
        case MultipleSelectionType.HairColor.rawValue:
            filterManager.memoryFilter.hairColor = options
            let text = options.count > 0 ? "Hair Colors: \(options.joined(separator: ", "))" : "Hair Colors: all"
            hairColorButton.setTitle(text, for: .normal)

        case MultipleSelectionType.Professions.rawValue:
            filterManager.memoryFilter.professions = options
            let text : String = options.count > 0 ? "Professions: \(options.joined(separator: ", "))" : "Professions: all"
            professionsButton.setTitle(text, for: .normal)

        case MultipleSelectionType.Friends.rawValue:
            filterManager.memoryFilter.friends = options
            let text : String = options.count > 0 ? "Friends: \(options.joined(separator: ", "))" : "Friends: all"
            friendsButton.setTitle(text, for: .normal)
        default: break
        }
        applyFilters()
    }
}
