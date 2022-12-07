// NewsTitleTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Title info about news owner
final class NewsTitleTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var titleNameLabel: UILabel!
    @IBOutlet var newsDateLabel: UILabel!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTitleImage()
    }

    // MARK: - Public Properties

    func configureCell(avatarImageName: String, titleName: String, newsUnixTimeDate: Int) {
        titleImageView.loadImage(urlName: avatarImageName)
        titleNameLabel.text = titleName
        newsDateLabel.text = dateConverter(unixTimeDate: newsUnixTimeDate)
    }

    // MARK: - Private Properties

    private func setupTitleImage() {
        titleImageView.layer.cornerRadius = 25
    }

    private func dateConverter(unixTimeDate: Int) -> String {
        let timeInterval = TimeInterval(unixTimeDate)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        return dateFormatter.string(from: date)
    }
}
