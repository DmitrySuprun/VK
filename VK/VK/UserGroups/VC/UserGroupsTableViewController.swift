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
    private let databaseService = DatabaseService()

    private var notificationToken = NotificationToken()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNotificationGroups()
        loadData()
    }

    // MARK: - Private Methods

    private func setupNotificationGroups() {
        do {
            let realm = try Realm()
            let objects = realm.objects(Group.self)

            notificationToken = objects.observe { changes in

                switch changes {
                case .initial:
                    self.tableView.reloadData()

                case let .update(result, deletions, insertions, modifications):

                    self.groups = Array(result)

                    self.tableView.performBatchUpdates({
                        self.tableView.deleteRows(
                            at: deletions.map { IndexPath(row: $0, section: 0) },
                            with: .automatic
                        )

                        self.tableView.insertRows(
                            at: insertions.map { IndexPath(row: $0, section: 0) },
                            with: .automatic
                        )

                        self.tableView.reloadRows(
                            at: modifications.map { IndexPath(row: $0, section: 0) },
                            with: .automatic
                        )
                    }, completion: { finished in
                        print("Update isFinished -", finished)
                    })

                case let .error(error):
                    print(#function, error)
                }
            }

        } catch {
            print(#function, error)
        }
    }

    private func loadData() {
        fetchGroups()
        guard let groups = databaseService.loadData(objectType: Group.self) else { return }
        self.groups = groups
        tableView.reloadData()
    }

    private func saveData(groupsForSave: [Group]) {
        databaseService.saveData(objects: groupsForSave)
    }

    private func setupTableView() {
        tableView.register(
            UINib(nibName: Constants.cellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.groupCellID
        )
    }

    private func fetchGroups() {
        networkService.fetchUserGroups(userID: Session.shared.userID ?? Constants.defaultUserID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(responseGroups):
                self.saveData(groupsForSave: responseGroups.groups)
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
