// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// NewsFeed
final class NewsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let newsTitleTableViewCellID = "newsTitleTableViewCellID"
        static let newsTitleTableViewCellNibName = "NewsTitleTableViewCell"

        static let newsContentTableViewCellID = "newsContentTableViewCellID"
        static let newsContentTableViewCellNibName = "NewsContentTableViewCell"

        static let newsButtonsTableViewCellID = "newsButtonsTableViewCellID"
        static let newsButtonsTableViewCellNibName = "NewsButtonsTableViewCell"

        static let emptyStringName = ""
    }

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private var newsFeed: NewsFeed?

    // MARK: - LifiCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        fetchNews()
    }

    // MARK: - Private Methods

    private func registerCell() {
        tableView.register(
            UINib(
                nibName: Constants.newsTitleTableViewCellNibName,
                bundle: nil
            ),
            forCellReuseIdentifier: Constants.newsTitleTableViewCellID
        )
        tableView.register(
            UINib(
                nibName: Constants.newsContentTableViewCellNibName,
                bundle: nil
            ),
            forCellReuseIdentifier: Constants.newsContentTableViewCellID
        )
        tableView.register(
            UINib(
                nibName: Constants.newsButtonsTableViewCellNibName,
                bundle: nil
            ),
            forCellReuseIdentifier: Constants.newsButtonsTableViewCellID
        )
    }

    private func fetchNews() {
        networkService.fetchNewsFeeds { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                self.newsFeed = result.response
                self.tableView.reloadData()
            case let .failure(error):
                print(#function, error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        newsFeed?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var newsOwnerID = newsFeed?.items[indexPath.section].ownerID
        if newsOwnerID == nil {
            newsOwnerID = newsFeed?.items[indexPath.section].sourceID
        }
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsTitleTableViewCellID,
                for: indexPath
            ) as? NewsTitleTableViewCell
            else { return UITableViewCell() }
            let newsOwnerProfile = newsFeed?.profiles.first { profile in
                profile.id == newsOwnerID
            }
            cell.configureCell(
                avatarImageURLName: newsOwnerProfile?.avatarImageURLName ?? Constants.emptyStringName,
                titleName: newsOwnerProfile?.fullName ?? Constants.emptyStringName,
                newsUnixTimeDate: newsFeed?.items[indexPath.section].date ?? 0,
                networkService: networkService
            )
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsContentTableViewCellID,
                for: indexPath
            ) as? NewsContentTableViewCell
            else { return UITableViewCell() }
            cell.configureCell(
                imageUrlName: newsFeed?.items[indexPath.section]
                    .attachments?.first?.photo?.sizes.last?.url
                    ?? newsFeed?.items[indexPath.section].photos?.items.first?.sizes.last?.url
                    ?? Constants.emptyStringName,
                newsText: newsFeed?.items[indexPath.section].text ?? Constants.emptyStringName,
                networkService: networkService
            )
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsButtonsTableViewCellID,
                for: indexPath
            ) as? NewsButtonsTableViewCell
            else { return UITableViewCell() }
            cell.configureCell(
                likeCount: newsFeed?.items[indexPath.section].likes?.count ?? 0,
                commentsCount: newsFeed?.items[indexPath.section].comments?.count ?? 0,
                shareCount: newsFeed?.items[indexPath.section].reposts?.count ?? 0,
                viewsCount: newsFeed?.items[indexPath.section].views?.count ?? 0
            )
            return cell
        default:
            return UITableViewCell()
        }
    }
}
