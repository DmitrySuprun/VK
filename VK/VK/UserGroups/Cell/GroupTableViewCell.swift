// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Group Info
final class GroupTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupsImageView: UIImageView!
    @IBOutlet private var groupsNameLabel: UILabel!

    // MARK: - Public Properties

    func configure(nameLabelText: String, groupsImageURLName: String, networkService: NetworkService) {
        groupsNameLabel.text = nameLabelText
        networkService.loadImage(urlName: groupsImageURLName) { [weak self] data in
            guard let data, let self else { return }
            self.groupsImageView.image = UIImage(data: data)
        }
    }
}
