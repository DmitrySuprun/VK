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
    }

    // MARK: - Private Properties

    private var news: ResponseNewsFeed?
    private let networkService = NetworkService()

    // MARK: - LifiCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        loadNews()
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

    private func loadNews() {
        networkService.fetchNewsFeeds { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                self.news = result
                self.tableView.reloadData()
            case let .failure(error):
                print(#function, error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        news?.newsFeedItems.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsOwnerID = news?.newsFeedItems[indexPath.section].ownerID
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsTitleTableViewCellID,
                for: indexPath
            ) as? NewsTitleTableViewCell
            else { return UITableViewCell() }
            let newsOwnerProfile = news?.newsFeedProfiles.first { profile in
                profile.id == newsOwnerID
            }
            let newsOwnerGroup = news?.newsFeedGroups.first { group in
                group.id == newsOwnerID
            }
            cell.configureCell(
                avatarImageName: newsOwnerProfile?.photo ?? "",
                titleName: newsOwnerProfile?.firstName ?? "",
                newsUnixTimeDate: news?.newsFeedItems.first?.date ?? 0
            )
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsContentTableViewCellID,
                for: indexPath
            ) as? NewsContentTableViewCell
            else { return UITableViewCell() }
            cell.configureCell(
                imageUrlName: news?.newsFeedItems[indexPath.section]
                    .attachments?.first?.photo?.sizes.last?.url ?? "",
                newsText: news?.newsFeedItems[indexPath.section].text ?? ""
            )
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsButtonsTableViewCellID,
                for: indexPath
            ) as? NewsButtonsTableViewCell
            else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
