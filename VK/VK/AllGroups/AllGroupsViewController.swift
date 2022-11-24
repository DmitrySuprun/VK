// AllGroupsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// All existing groups
final class AllGroupsViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let groupCellID = "groupCellID"
        static let cellNibName = "GroupTableViewCell"
    }

    // MARK: - IBOutlets

    @IBOutlet private var groupsSearchBar: UISearchBar!

    // MARK: - Public Properties

    var groups: [GroupsItems] = []

    // MARK: - Private Properties

    private var networkService = NetworkService()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Private Methods

    private func fetchGroupsSearch(searchName: String) {
        networkService.fetchGroupsSearch(searchName: searchName) { [weak self] result in
            switch result {
            case let .success(groups): self?.groups = groups.response.items
            case let .failure(error): print(error)
            }
            self?.tableView?.reloadData()
        }
    }

    private func setupTableView() {
        tableView.register(
            UINib(nibName: Constants.cellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.groupCellID
        )
    }

    // MARK: - TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.groupCellID,
            for: indexPath
        ) as? GroupTableViewCell
        else { return UITableViewCell() }
        cell.configure(nameLabelText: groups[indexPath.row].name, groupsImageName: groups[indexPath.row].photo)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension AllGroupsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchGroupsSearch(searchName: searchText)
    }
}
