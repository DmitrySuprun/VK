// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Group Info
final class GroupTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupsImageView: UIImageView!
    @IBOutlet private var groupsNameLabel: UILabel!

    // MARK: - Public Properties

    func configure(nameLabelText: String, groupsImageName: String) {
        groupsNameLabel.text = nameLabelText
        groupsImageView.image = UIImage(named: groupsImageName)
    }
}
