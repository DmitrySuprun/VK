// AllGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// All existing groups
final class AllGroupsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let groupCellID = "groupCellID"
        static let cellNibName = "GroupTableViewCell"
    }

    // MARK: - Public Properties

    var groups = [
        Group(name: "North", imageName: "101"),
        Group(name: "South", imageName: "102"),
        Group(name: "West", imageName: "103"),
        Group(name: "East", imageName: "104"),
        Group(name: "Earth", imageName: "105"),
        Group(name: "Water", imageName: "106"),
        Group(name: "Air", imageName: "100")
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let userGroupsViewController =
            navigationController?.viewControllers.first as? UserGroupsTableViewController
        else { return }

        if !userGroupsViewController.groups.contains(where: { $0.name == groups[indexPath.row].name }) {
            userGroupsViewController.groups.append(groups[indexPath.row])
            userGroupsViewController.tableView.reloadData()
        }
        navigationController?.popViewController(animated: true)
    }
}
