// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Friends info cell
final class FriendsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var avatarView: AvatarView!
    @IBOutlet private var nameLabel: UILabel!

    func configure(nameLabelText: String, avatarImageName: String) {
        nameLabel.text = nameLabelText
        avatarView.image = UIImage(named: avatarImageName)
    }
}
