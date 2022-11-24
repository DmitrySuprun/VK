// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// NewsFeed
final class NewsTableViewController: UITableViewController {
    // MARK: - Constants

    private struct Constants {
        static let newsTableViewCellID = "newsTableViewCellID"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.newsTableViewCellID,
            for: indexPath
        ) as? NewsTableViewCell
        else { return UITableViewCell() }
        return cell
    }
}
