// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// UserGroups List
final class UserGroupsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let groupCellID = "groupCellID"
        static let cellNibName = "GroupTableViewCell"
    }

    // MARK: - Public Properties

    var groups: [Group] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.register(
            UINib(nibName: Constants.cellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.groupCellID
        )
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
        cell.configure(nameLabelText: group.name, groupsImageName: group.imageName)
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
