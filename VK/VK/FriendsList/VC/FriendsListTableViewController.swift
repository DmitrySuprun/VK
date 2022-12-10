// FriendsListTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import PromiseKit
import UIKit

/// Friends List
final class FriendsListTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendsCellID = "friendsCellID"
        static let friendsInfoSegueID = "friendsInfoSegueID"
        static let emptyCharacter = Character("")
    }

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private let networkServiceFriends = FriendsNetworkService()
    private var sortedFriendsMap: [Character: [Friend]] = [:]
    private var databaseService = DatabaseService()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
        loadFriendsFromDatabaseService()
    }

    // MARK: - Private Methods

    private func setupNotification() {
        databaseService.setupNotification(objectType: Friend.self) { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial:
                self.tableView.reloadData()

                // MARK: - TODO Fix delete objects

            case let .update(results, deletions, _, _):
                guard deletions.isEmpty else { return }
                self.makeSortedFriendsMap(friendsInfo: Array(results))
                self.tableView.reloadData()
            case .error:
                break
            }
        }
    }

    private func loadFriendsFromDatabaseService() {
        fetchFriends()
        guard let friends = databaseService.load(objectType: Friend.self) else { return }
        makeSortedFriendsMap(friendsInfo: friends)
        tableView.reloadData()
    }

    private func fetchFriends() {
        firstly {
            networkServiceFriends.fetchFriends()
        }.done { responseFriends in
            self.databaseService.save(objects: responseFriends.friends)
        }.catch { error in
            print(#function)
            print(error.localizedDescription)
        }
    }

    private func makeSortedFriendsMap(friendsInfo: [Friend]) {
        var friendsMap: [Character: [Friend]] = [:]
        for info in friendsInfo {
            if let key = info.lastName.first {
                if friendsMap[key] == nil {
                    friendsMap[key] = [info]
                } else {
                    friendsMap[key]?.append(info)
                    friendsMap[key]?.sort {
                        $0.lastName.first ?? Constants.emptyCharacter > $1.lastName.first ?? Constants.emptyCharacter
                    }
                }
            }
        }
        sortedFriendsMap = friendsMap
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.friendsInfoSegueID,
              let userPhotosViewController = segue.destination as? UserPhotosCollectionViewController
        else { return }
        guard let friendInfoIndexPath = tableView.indexPathForSelectedRow else { return }
        let sortedKeys = sortedFriendsMap.keys.sorted()
        let key = sortedKeys[friendInfoIndexPath.section]
        guard let friendsInfo = sortedFriendsMap[key]?[friendInfoIndexPath.row] else { return }
        userPhotosViewController.userID = friendsInfo.id
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedFriendsMap.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sortedKeys = sortedFriendsMap.keys.sorted()
        let key = sortedKeys[section]
        return sortedFriendsMap[key]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendsCellID,
            for: indexPath
        ) as? FriendsTableViewCell
        else { return UITableViewCell() }
        let sortedKeys = sortedFriendsMap.keys.sorted()
        let key = sortedKeys[indexPath.section]
        guard let friendsListSection = sortedFriendsMap[key] else { return UITableViewCell() }
        if friendsListSection.indices.contains([indexPath.row]) {
            let friend = friendsListSection[indexPath.row]
            cell.configure(
                nameLabelText: "\(friend.lastName) \(friend.firstName)",
                avatarImageURLName: friend.photo,
                networkService: networkService
            )
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sortedKeys = sortedFriendsMap.keys.sorted()
        return String(sortedKeys[section])
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as? UITableViewHeaderFooterView
        headerView?.contentView.backgroundColor = .systemGray6
        headerView?.contentView.alpha = 0.3
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        // MARK: - TODO Fix delete objects

        guard editingStyle == .delete else { return }
        let sortedKeys = sortedFriendsMap.keys.sorted()
        let key = sortedKeys[indexPath.section]
        guard let friend = sortedFriendsMap[key]?.remove(at: indexPath.row) else { return }
        tableView.deleteRows(at: [indexPath], with: .fade)
        if tableView.numberOfRows(inSection: indexPath.row) == 1 {
            tableView.deleteSections(IndexSet(indexPath), with: .fade)
        }
        databaseService.delete(object: friend)
    }
}
