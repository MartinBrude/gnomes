//
//  ViewController.swift
//  GnomesBrowser
//
//  Created by Martin on 15/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import UIKit

class GnomesViewController: UIViewController {

    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var feedbackMessageLabel: UILabel!

    var coordinator : Coordinator?
    var service : GnomesServiceProtocol?
    var gnomeViewModels : [GnomeViewModel]? {
        didSet {
            tableView.reloadData()
        }
    }

    private func setupLayout() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonPressed))
        let nib = UINib(nibName: GnomeCell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: GnomeCell.reuseIdentifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        fetchGnomes()
    }

    private func fetchGnomes() {
        activityIndicator.startAnimating()
        feedbackMessageLabel.isHidden = true
        service?.fetchGnomes(successful: { [weak self] (gnomes) in
            DispatchQueue.main.async {
                self?.tableView.separatorStyle = .singleLine
                self?.activityIndicator.stopAnimating()
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
            }
            //by default all gnomes are not filtered
            self?.gnomeViewModels = gnomes.map{GnomeViewModel(gnome: $0, visible: true)}
            }, failure: { [weak self] (failure) in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.feedbackMessageLabel.isHidden = false
                    self?.navigationItem.rightBarButtonItem?.isEnabled = false
                }
        })
    }

    @objc func filterButtonPressed() {
        coordinator?.presentFilters(gnomes: gnomeViewModels?.map({$0.gnome}), delegate: self)
    }
}

extension GnomesViewController : FilterControllerDelegate {
    func didSaveFilters(gnomes: [Gnome]) {
        gnomeViewModels?.forEach({ (viewModel) in
            viewModel.visible = gnomes.contains(where: {$0.id == viewModel.gnome.id })
        })
        tableView.reloadData()
        if gnomes.count > 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: false)
            tableView.separatorStyle = .singleLine
        } else {
            tableView.separatorStyle = .none
            feedbackMessageLabel.text = "There are no gnomes for this settings :("
        }
        feedbackMessageLabel.isHidden = gnomes.count > 0
    }
}

extension GnomesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gnomeViewModels?.filter({$0.visible}).count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GnomeCell.reuseIdentifier, for: indexPath) as? GnomeCell
        if let gnomeViewModel = gnomeViewModels?.filter({$0.visible})[indexPath.row] {
            cell?.setGnome(gnomeViewModel.gnome)
        }

        return cell!
    }
}
