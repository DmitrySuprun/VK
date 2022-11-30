// FriendsListTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Friends List
final class FriendsListTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendsCellID = "friendsCellID"
        static let friendsInfoSegueID = "friendsInfoSegueID"
        static let emptyCharacter = Character("")
    }

    // MARK: - Public Properties

    var friends: [Friend] = []

    // MARK: - Private Properties

    private var sortedFriendsMap: [Character: [Friend]] = [:]
    private let networkService = NetworkService()
    private let databaseService = DatabaseService()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        makeFriendsSortedMap(friendsInfo: friends)
        loadFriendsFromDatabaseService()
    }

    // MARK: - Private Methods

    private func loadFriendsFromDatabaseService() {
        fetchData()
        guard let friends = databaseService.load(objectType: Friend.self) else { return }
        makeFriendsSortedMap(friendsInfo: friends)
        tableView.reloadData()
    }

    private func saveInDatabaseService() {
        databaseService.save(objects: friends)
    }

    private func fetchData() {
        networkService.fetchFriends { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(responseFriends):
                self.friends = responseFriends.friends
                self.saveInDatabaseService()
            case let .failure(error):
                print(error)
            }
        }
    }

    private func makeFriendsSortedMap(friendsInfo: [Friend]) {
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
                avatarImageName: friend.photo
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
}
