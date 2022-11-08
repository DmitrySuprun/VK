// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Friends info cell
final class FriendsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var avatarView: AvatarView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Public Properties

    func configure(nameLabelText: String, avatarImageName: String) {
        nameLabel.text = nameLabelText
        avatarView.image = UIImage(named: avatarImageName)
    }

    // MARK: - Private Properties

    private func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchAnimation))
        avatarView.isUserInteractionEnabled = true
        avatarView.addGestureRecognizer(tapGesture)
    }

    @objc private func touchAnimation() {
        let animation = CASpringAnimation(keyPath: #keyPath(CALayer.bounds))
        animation.fromValue = CGRect(
            x: 0,
            y: 0,
            width: avatarView.bounds.width - 5,
            height: avatarView.bounds.height - 5
        )
        animation.toValue = avatarView.bounds
        animation.initialVelocity = 0.1
        animation.damping = 0.7
        animation.stiffness = 70
        animation.mass = 0.1
        animation.duration = 1
        avatarView.layer.add(animation, forKey: nil)
    }
}
