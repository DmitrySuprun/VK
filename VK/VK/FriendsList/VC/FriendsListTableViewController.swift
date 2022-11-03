// FriendsListTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Friends List
final class FriendsListTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendsCellID = "friendsCellID"
        static let friendsInfoSegueID = "friendsInfoSegueID"
    }

    // MARK: - Public Properties

    var friendsList = [
        FriendsInfo(name: "Salvadore", avatarName: "0", likesCout: 10),
        FriendsInfo(name: "Ivan", avatarName: "1", likesCout: 1),
        FriendsInfo(name: "Piotr", avatarName: "2", likesCout: 2),
        FriendsInfo(name: "Hleb", avatarName: "3", likesCout: 3),
        FriendsInfo(name: "Sergey", avatarName: "4", likesCout: 4),
        FriendsInfo(name: "Helen", avatarName: "5", likesCout: 5),
        FriendsInfo(name: "Uli", avatarName: "6", likesCout: 6),
        FriendsInfo(name: "Victory", avatarName: "7", likesCout: 7),
        FriendsInfo(name: "Vaclav", avatarName: "8", likesCout: 8),
        FriendsInfo(name: "Gradine", avatarName: "9", likesCout: 9),
        FriendsInfo(name: "Andrew", avatarName: "10", likesCout: 10),
        FriendsInfo(name: "Roma", avatarName: "11", likesCout: 11),
        FriendsInfo(name: "Yaris", avatarName: "12", likesCout: 12),
        FriendsInfo(name: "Helen", avatarName: "13", likesCout: 13),
        FriendsInfo(name: "Philip", avatarName: "14", likesCout: 14),
        FriendsInfo(name: "Alex", avatarName: "15", likesCout: 15),
        FriendsInfo(name: "Joan", avatarName: "16", likesCout: 14),
        FriendsInfo(name: "Selena", avatarName: "17", likesCout: 13),
        FriendsInfo(name: "Boris", avatarName: "18", likesCout: 12),
        FriendsInfo(name: "Nikolas", avatarName: "19", likesCout: 11),
        FriendsInfo(name: "Ury", avatarName: "20", likesCout: 10),
        FriendsInfo(name: "Dmitry", avatarName: "21", likesCout: 9),
        FriendsInfo(name: "Kirill", avatarName: "22", likesCout: 8),
        FriendsInfo(name: "Tatiana", avatarName: "23", likesCout: 7),
        FriendsInfo(name: "Olga", avatarName: "24", likesCout: 6),
        FriendsInfo(name: "Lisa", avatarName: "25", likesCout: 5),
        FriendsInfo(name: "Inna", avatarName: "26", likesCout: 4),
        FriendsInfo(name: "Mary", avatarName: "27", likesCout: 3),
        FriendsInfo(name: "Constantin", avatarName: "28", likesCout: 2),
        FriendsInfo(name: "Evgeny", avatarName: "29", likesCout: 1),
        FriendsInfo(name: "Zina", avatarName: "30", likesCout: 0),
        FriendsInfo(name: "Vlad", avatarName: "31", likesCout: 1),
        FriendsInfo(name: "Visy", avatarName: "32", likesCout: 2),
        FriendsInfo(name: "Mihail", avatarName: "33", likesCout: 3),
        FriendsInfo(name: "Pol", avatarName: "34", likesCout: 4),
        FriendsInfo(name: "John", avatarName: "35", likesCout: 5),
        FriendsInfo(name: "Ella", avatarName: "36", likesCout: 6),
        FriendsInfo(name: "Antony", avatarName: "37", likesCout: 7),
        FriendsInfo(name: "Shone", avatarName: "38", likesCout: 8),
        FriendsInfo(name: "Ibrahim", avatarName: "39", likesCout: 9)
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.friendsInfoSegueID,
              let userPhotosViewController = segue.destination as? UserPhotosCollectionViewController
        else { return }
        let photoIndex = tableView.indexPathForSelectedRow?.row ?? 0
        userPhotosViewController.photos.append(friendsList[photoIndex].avatarName)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.friendsCellID,
            for: indexPath
        ) as? FriendsTableViewCell
        else { return UITableViewCell() }
        let friendsInfo = friendsList[indexPath.row]
        cell.configure(nameLabelText: friendsInfo.name, avatarImageName: friendsInfo.avatarName)
        return cell
    }
}
