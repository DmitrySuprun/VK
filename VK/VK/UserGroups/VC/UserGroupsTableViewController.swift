// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// UserGroups List
final class UserGroupsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let groupCellID = "groupCellID"
        static let cellNibName = "GroupTableViewCell"
        static let defaultUserID = 0
    }

    // MARK: - Public Properties

    var groups: [Group] = []

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private var databaseService = DatabaseService()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

    // MARK: - Private Methods

    private func setupViewController() {
        setupTableView()
        setupNotificationGroups()
        loadGroupFromDatabaseService()
    }

    private func setupNotificationGroups() {
        databaseService.setupNotification(objectType: Group.self) { [weak self] changes in
            guard let self = self else { return }

            switch changes {
            case .initial:
                self.tableView.reloadData()

            case let .update(result, deletions, insertions, modifications):
                self.groups = Array(result)
                self.tableView.performBatchUpdates({
                    self.tableView.deleteRows(
                        at: deletions.map { IndexPath(row: $0, section: 0) },
                        with: .fade
                    )

                    self.tableView.insertRows(
                        at: insertions.map { IndexPath(row: $0, section: 0) },
                        with: .fade
                    )

                    self.tableView.reloadRows(
                        at: modifications.map { IndexPath(row: $0, section: 0) },
                        with: .fade
                    )
                })

            case let .error(error):
                print(#function, error)
            }
        }
    }

    private func loadGroupFromDatabaseService() {
        fetchUserGroups()
        guard let groups = databaseService.load(objectType: Group.self) else { return }
        self.groups = groups
        tableView.reloadData()
    }

    private func saveInDatabaseService(groups: [Group]) {
        databaseService.save(objects: groups)
    }

    private func setupTableView() {
        tableView.register(
            UINib(nibName: Constants.cellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.groupCellID
        )
    }

    private func fetchUserGroups() {
        networkService.fetchUserGroups(userID: Session.shared.userID ?? Constants.defaultUserID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(responseGroups):
                self.saveInDatabaseService(groups: responseGroups.groups)
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
        cell.configure(
            nameLabelText: group.name,
            groupsImageURLName: group.photo,
            networkService: networkService
        )
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        let group = groups[indexPath.row]
        databaseService.delete(object: group)
    }
}
