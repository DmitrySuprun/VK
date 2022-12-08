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
        networkService.loadImage(urlName: groupsImageURLName) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                guard let data else { return }
                self.groupsImageView.image = UIImage(data: data)
            case let .failure(error):
                print(#function, error)
            }
        }
    }
}
