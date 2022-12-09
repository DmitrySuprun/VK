// AllGroupsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// All existing groups
final class AllGroupsViewController: UITableViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let groupCellID = "groupCellID"
        static let cellNibName = "GroupTableViewCell"
        static let storyboardName = "Main"
        static let userGroupsViewControllerID = "userGroupsViewControllerID"
    }

    // MARK: - IBOutlets

    @IBOutlet private var groupsSearchBar: UISearchBar!

    // MARK: - Public Properties

    var groups: [Group] = []

    // MARK: - Private Properties

    private var networkService = NetworkService()
    private var databaseService = DatabaseService()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Private Methods

    private func fetchGroups(searchName: String) {
        networkService.fetchGroupsSearch(searchName: searchName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(responseGroups): self.groups = responseGroups.groups
            case let .failure(error): print(error)
            }
            self.tableView?.reloadData()
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
        cell.configure(
            nameLabelText: groups[indexPath.row].name,
            groupsImageURLName:
            groups[indexPath.row].photo,
            networkService: networkService
        )
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        databaseService.save(objects: [groups[indexPath.row]])
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension AllGroupsViewController: UISearchBarDelegate {
    // MARK: - UISearchBarDelegate Methods

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchGroups(searchName: searchText)
    }
}
