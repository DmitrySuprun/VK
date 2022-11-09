// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// NewsFeed description
final class NewsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var userAvatarImageView: UIImageView!

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        userAvatarImageView.layer.cornerRadius = 25
        userAvatarImageView.clipsToBounds = true
    }
}
