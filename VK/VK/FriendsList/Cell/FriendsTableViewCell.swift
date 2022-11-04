// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Friends info cell
final class FriendsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

//    @IBOutlet private var avatarImageView: UIImageView!

    @IBOutlet var avatarView: AvatarView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Public Methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(nameLabelText: String, avatarImageName: String) {
        nameLabel.text = nameLabelText
        avatarView.image = UIImage(named: avatarImageName)
    }
}
