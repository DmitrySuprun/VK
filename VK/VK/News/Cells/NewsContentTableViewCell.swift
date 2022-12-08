// NewsContentTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Content of news
final class NewsContentTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var contentImageView: UIImageView!
    @IBOutlet private var contentLabel: UILabel!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.numberOfLines = 0
    }

    // MARK: - Public Properties

    func configureCell(imageUrlName: String, newsText: String, networkService: NetworkService) {
        contentLabel.text = newsText
        networkService.loadImage(urlName: imageUrlName) { [weak self] data in
            guard let data, let self else { return }
            self.contentImageView.image = UIImage(data: data)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.image = nil
    }
}
