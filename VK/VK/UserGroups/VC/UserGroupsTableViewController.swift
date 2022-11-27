// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// UserGroups List
final class UserGroupsTableViewController: UITableViewController {
    // MARK: - Constants

    private struct Constants {
        static let groupCellID = "groupCellID"
        static let cellNibName = "GroupTableViewCell"
    }

    // MARK: - Public Properties

    var groups: [Group] = []

    // MARK: - Private Properties

    private let networkService = NetworkService()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchGroups()
    }

    // MARK: - Private Methods

    private func setupTableView() {
        tableView.register(
            UINib(nibName: Constants.cellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.groupCellID
        )
    }

    private func fetchGroups() {
        networkService.fetchUserGroups(userID: 159_716_695) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(responseGroups):
                self.groups = responseGroups.groups
            case let .failure(error):
                print(error)
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

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
        let group = groups[indexPath.row]
        cell.configure(nameLabelText: group.name, groupsImageName: group.photo)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        groups.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
