// NewsContentTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Content of news
class NewsContentTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var contentLabel: UILabel!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.numberOfLines = 0
    }

    // MARK: - Public Properties

    func configureCell(imageUrlName: String, newsText: String) {
        contentImageView.loadImage(urlName: imageUrlName)
        contentLabel.text = newsText
    }
}
