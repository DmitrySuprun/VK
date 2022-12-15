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

        static let newsImagesTableViewCellID = "newsImagesTableViewCellID"
        static let newsImagesTableViewCell = "NewsImagesTableViewCell"

        static let emptyStringName = ""
        static let refreshingText = "Refreshing..."
    }

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private var newsFeed: NewsFeed?

    private var nextNewsFrom = Constants.emptyStringName
    private var isNewsLoading = false

    // MARK: - LifiCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewController()
    }

    // MARK: - Private @Objc Methods

    @objc private func refreshNews() {
        fetchNewsFeed()
    }

    // MARK: - Private Methods

    private func setupTableViewController() {
        setupRefreshControl()
        registerCell()
        setupTableView()
        fetchNewsFeed()
    }

    private func setupTableView() {
        tableView.prefetchDataSource = self
    }

    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: Constants.refreshingText)
        refreshControl?.tintColor = .systemBlue
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }

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
        tableView.register(
            UINib(
                nibName: Constants.newsImagesTableViewCell,
                bundle: nil
            ),
            forCellReuseIdentifier: Constants.newsImagesTableViewCellID
        )
    }

    private func fetchNewsFeed() {
        networkService.fetchNewsFeeds(startFrom: Constants.emptyStringName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                self.newsFeed = result.response
                self.nextNewsFrom = result.response.nextFrom ?? Constants.emptyStringName
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            case let .failure(error):
                print(error.localizedDescription)
                self.refreshControl?.endRefreshing()
            }
        }
    }

    private func fetchNewsFeedPrevious() {
        networkService.fetchNewsFeeds(startFrom: nextNewsFrom) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                let indexSet = IndexSet(
                    integersIn:
                    (self.newsFeed?.items.count ?? 0) ..<
                        (self.newsFeed?.items.count ?? 0) + response.response.items.count
                )
                self.newsFeed?.items.append(contentsOf: response.response.items)
                self.newsFeed?.groups.append(contentsOf: response.response.groups)
                self.nextNewsFrom = response.response.nextFrom ?? Constants.emptyStringName
                self.tableView.insertSections(indexSet, with: .automatic)
                self.isNewsLoading = false
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        newsFeed?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
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
            if newsOwnerProfile == nil {
                let newsOwnerGroup = newsFeed?.groups.first { group in
                    group.id == (newsOwnerID ?? 0) * -1
                }
                cell.configureCell(
                    avatarImageURLName: newsOwnerGroup?.photo ?? Constants.emptyStringName,
                    titleName: newsOwnerGroup?.name ?? Constants.emptyStringName,
                    newsUnixTimeDate: newsFeed?.items[indexPath.section].date ?? 0,
                    networkService: networkService
                )
            } else {
                cell.configureCell(
                    avatarImageURLName: newsOwnerProfile?.avatarImageURLName ?? Constants.emptyStringName,
                    titleName: newsOwnerProfile?.fullName ?? Constants.emptyStringName,
                    newsUnixTimeDate: newsFeed?.items[indexPath.section].date ?? 0,
                    networkService: networkService
                )
            }

            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsContentTableViewCellID,
                for: indexPath
            ) as? NewsContentTableViewCell
            else { return UITableViewCell() }
            cell.configure(
                newsText: newsFeed?.items[indexPath.section].text ?? Constants.emptyStringName
            )
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.newsImagesTableViewCellID,
                for: indexPath
            ) as? NewsImagesTableViewCell
            else { return UITableViewCell() }
            cell.configure(
                imageName: newsFeed?.items[indexPath.section].attachments?.first?.photo?.sizes.last?.url
                    ?? Constants.emptyStringName
            )
            return cell
        case 3:
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            let tableWidth = tableView.bounds.width
            let imageAspectRatio = (
                newsFeed?.items[indexPath.section]
                    .attachments?.first?.photo?.sizes.last?.aspectRatio
                    ?? newsFeed?.items[indexPath.section].photos?.items.first?.sizes.last?.aspectRatio
            )
                ?? 1
            let cellHeight = tableWidth * imageAspectRatio
            return cellHeight
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension NewsTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map(\.section).max(),
              let newsFeed
        else { return }
        if maxSection > newsFeed.items.count - 3, !isNewsLoading {
            isNewsLoading = true
            fetchNewsFeedPrevious()
        }
    }
}
