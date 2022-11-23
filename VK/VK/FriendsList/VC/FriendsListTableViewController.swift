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

    var users = [
        UserInfo(name: "Salvadore", avatarName: "0", likesCount: 10),
        UserInfo(name: "Ivan", avatarName: "1", likesCount: 13),
        UserInfo(name: "Piotr", avatarName: "2", likesCount: 23),
        UserInfo(name: "Hleb", avatarName: "3", likesCount: 32),
        UserInfo(name: "Sergey", avatarName: "4", likesCount: 43),
        UserInfo(name: "Helen", avatarName: "5", likesCount: 54),
        UserInfo(name: "Uli", avatarName: "6", likesCount: 62),
        UserInfo(name: "Victory", avatarName: "7", likesCount: 73),
        UserInfo(name: "Vaclav", avatarName: "8", likesCount: 84),
        UserInfo(name: "Gradine", avatarName: "9", likesCount: 93),
        UserInfo(name: "Andrew", avatarName: "10", likesCount: 10),
        UserInfo(name: "Roma", avatarName: "11", likesCount: 11),
        UserInfo(name: "Yaris", avatarName: "12", likesCount: 12),
        UserInfo(name: "Helen", avatarName: "13", likesCount: 13),
        UserInfo(name: "Philip", avatarName: "14", likesCount: 14),
        UserInfo(name: "Alex", avatarName: "15", likesCount: 15),
        UserInfo(name: "Joan", avatarName: "16", likesCount: 14),
        UserInfo(name: "Selena", avatarName: "17", likesCount: 13),
        UserInfo(name: "Boris", avatarName: "18", likesCount: 12),
        UserInfo(name: "Nikolas", avatarName: "19", likesCount: 11),
        UserInfo(name: "Ury", avatarName: "20", likesCount: 10),
        UserInfo(name: "Dmitry", avatarName: "21", likesCount: 93),
        UserInfo(name: "Kirill", avatarName: "22", likesCount: 83),
        UserInfo(name: "Tatiana", avatarName: "23", likesCount: 73),
        UserInfo(name: "Olga", avatarName: "24", likesCount: 64),
        UserInfo(name: "Lisa", avatarName: "25", likesCount: 54),
        UserInfo(name: "Inna", avatarName: "26", likesCount: 44),
        UserInfo(name: "Mary", avatarName: "27", likesCount: 33),
        UserInfo(name: "Constantin", avatarName: "28", likesCount: 22),
        UserInfo(name: "Evgeny", avatarName: "29", likesCount: 13),
        UserInfo(name: "Zina", avatarName: "30", likesCount: 32),
        UserInfo(name: "Vlad", avatarName: "31", likesCount: 45),
        UserInfo(name: "Visy", avatarName: "32", likesCount: 28),
        UserInfo(name: "Mihail", avatarName: "33", likesCount: 36),
        UserInfo(name: "Pol", avatarName: "34", likesCount: 46),
        UserInfo(name: "John", avatarName: "35", likesCount: 58),
        UserInfo(name: "Ella", avatarName: "36", likesCount: 69),
        UserInfo(name: "Antony", avatarName: "37", likesCount: 74),
        UserInfo(name: "Shone", avatarName: "38", likesCount: 85),
        UserInfo(name: "Ibrahim", avatarName: "39", likesCount: 96)
    ]

    // MARK: - Private Properties

    private var sortedFriendsMap: [Character: [UserInfo]] = [:]
    private var networkService = NetworkService()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        makeFriendsSortedMap(friendsInfo: users)
        fetchData()
    }

    // MARK: - Private Methods
    
    private func fetchData() {
        // Friends
        networkService.fetchData(method: "friends.get", queryItems: [URLQueryItem(name: "fields", value: "nickname")])
        // Photos
        networkService.fetchData(method: "photos.getAll", queryItems: [URLQueryItem(name: "owner_id", value: "159716695")])
        // Groups
        networkService.fetchData(method: "groups.get", queryItems: [URLQueryItem(name: "owner_id", value: "159716695")])
        // Groups search
        networkService.fetchData(method: "groups.search", queryItems: [URLQueryItem(name: "q", value: "котики")])
    }

    private func makeFriendsSortedMap(friendsInfo: [UserInfo]) {
        var friendsMap: [Character: [UserInfo]] = [:]
        for info in friendsInfo {
            if let key = info.name.first {
                if friendsMap[key] == nil {
                    friendsMap[key] = [info]
                } else {
                    friendsMap[key]?.append(info)
                    friendsMap[key]?.sort {
                        $0.name.first ?? Constants.emptyCharacter > $1.name.first ?? Constants.emptyCharacter
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
        userPhotosViewController.usersInfo.append(friendsInfo)
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
        let friendsInfo = friendsListSection[indexPath.row]
        cell.configure(nameLabelText: friendsInfo.name, avatarImageName: friendsInfo.avatarName)
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
