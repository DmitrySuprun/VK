// NewsImagesTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// News images content
final class NewsImagesTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var contentImageView: UIImageView!

    // MARK: - Private Properties

    private let networkService = NetworkService()

    // MARK: - Public Methods

    func configureCell(imageName: String) {
        networkService.loadImage(urlName: imageName) { [weak self] result in
            switch result {
            case let .success(data):
                guard let data, let self else { return }
                self.contentImageView.image = UIImage(data: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
