// UserPhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User Single ImagePost
final class UserPhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutletsz

    @IBOutlet private var userPhotoImageView: UIImageView!
    @IBOutlet var likeControl: LikeControl!

    // MARK: - Life Cycle

    // MARK: - Public Methods

    func configure(imageName: String, likesCount: Int) {
        userPhotoImageView.image = UIImage(named: imageName)
        likeControl.likeCount = likesCount
    }
}
