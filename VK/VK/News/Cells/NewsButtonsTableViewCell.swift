// NewsButtonsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Button for display and manage reactions and status of news
final class NewsButtonsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var commentsButton: UIButton!
    @IBOutlet private var shareButton: UIButton!
    @IBOutlet private var viewsButton: UIButton!

    // MARK: - Public Methods

    func configureCell(likeCount: Int, commentsCount: Int, shareCount: Int, viewsCount: Int) {
        likeButton.setTitle(String(likeCount), for: .normal)
        commentsButton.setTitle(String(commentsCount), for: .normal)
        shareButton.setTitle(String(shareCount), for: .normal)
        viewsButton.setTitle(String(viewsCount), for: .normal)
    }
}
