// NewsContentTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Content of news
final class NewsContentTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var contentLabel: UILabel!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.numberOfLines = 0
    }

    // MARK: - Public Methods

    func configure(newsText: String) {
        contentLabel.text = newsText
    }
}
