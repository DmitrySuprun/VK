// UserPhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User Single ImagePost
final class UserPhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var userPhotoImageView: UIImageView!

    // MARK: - Public Methods

    func configure(imageName: String) {
        userPhotoImageView.image = UIImage(named: imageName)
    }
}
