// NewsTitleTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Title info about news owner
final class NewsTitleTableViewCell: UITableViewCell {
    // MARK: - Private Constants

    private enum Constants {
        static let dateFormatName = "dd.MM.yyyy HH:mm"
        static let titleImageCornerRadius: CGFloat = 25
    }

    // MARK: - IBOutlets

    @IBOutlet private var titleImageView: UIImageView!
    @IBOutlet private var titleNameLabel: UILabel!
    @IBOutlet private var newsDateLabel: UILabel!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTitleImage()
    }

    // MARK: - Public Properties

    func configureCell(
        avatarImageURLName: String,
        titleName: String,
        newsUnixTimeDate: Int,
        networkService: NetworkService
    ) {
        titleNameLabel.text = titleName
        newsDateLabel.text = dateConverter(unixTimeDate: newsUnixTimeDate)
        networkService.loadImage(urlName: avatarImageURLName) { [weak self] data in
            guard let data, let self else { return }
            self.titleImageView.image = UIImage(data: data)
        }
    }

    // MARK: - Private Properties

    private func setupTitleImage() {
        titleImageView.layer.cornerRadius = Constants.titleImageCornerRadius
    }

    private func dateConverter(unixTimeDate: Int) -> String {
        let timeInterval = TimeInterval(unixTimeDate)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatName
        return dateFormatter.string(from: date)
    }
}
