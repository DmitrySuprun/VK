// UserPhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User Single ImagePost
final class UserPhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutletsz

    @IBOutlet private var userPhotoImageView: UIImageView!
    @IBOutlet private var likeControl: LikeControl!

    // MARK: - Public Methods

    func configure(imageName: String, likesCount: Int, isLiked: Bool) {
        userPhotoImageView.loadImage(urlName: imageName)
        likeControl.likeCount = likesCount
        likeControl.isLiked = isLiked
    }
}
