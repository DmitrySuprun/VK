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

    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.image = nil
    }

    func configureCell(imageUrlName: String, newsText: String, networkService: NetworkService) {
        contentLabel.text = newsText
        networkService.loadImage(urlName: imageUrlName) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                guard let data else { return }
                self.contentImageView.image = UIImage(data: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
