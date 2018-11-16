//
//  MultipleSelectionViewController.swift
//  GnomesBrowser
//
//  Created by Martin on 17/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import UIKit

enum MultipleSelectionType : String {
    case HairColor = "Hair Colors"
    case Professions = "Professions"
    case Friends = "Friends"
}

protocol MultipleOptionsDelegate : class {
    func didSelectOptions(options: [String], filter : String)
}

class MultipleSelectionViewController: UITableViewController {

    weak var delegate : MultipleOptionsDelegate?
    var type : MultipleSelectionType?
    var chosenAttributes : [String]?

    var items = [Item]() {
        didSet {
            tableView.reloadData()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear all", style: .plain, target: self, action: #selector(clearAll))
    }

    @objc private func clearAll() {
        for (index, _) in items.enumerated() {
            items[index].isSelected = false
        }
        delegate?.didSelectOptions(options: items.filter{$0.isSelected}.map{$0.text}, filter: type!.rawValue)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let item = items[indexPath.row]
        toggleCellCheckbox(cell, isSelected: !item.isSelected)
        items[indexPath.row].isSelected = !item.isSelected
        delegate?.didSelectOptions(options: items.filter{$0.isSelected}.map{$0.text}, filter: type!.rawValue)
    }

    func toggleCellCheckbox(_ cell: UITableViewCell, isSelected: Bool) {
        cell.accessoryType = !isSelected ? .none : .checkmark
        cell.textLabel?.textColor = !isSelected ? .black : .gray
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text
        let isSelected = items[indexPath.row].isSelected
        toggleCellCheckbox(cell, isSelected: isSelected)
        return cell
    }
}
