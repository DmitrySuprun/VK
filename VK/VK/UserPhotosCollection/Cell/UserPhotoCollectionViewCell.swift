// UserPhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User Single ImagePost
final class UserPhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var userPhotoImageView: UIImageView!
    @IBOutlet private var likeControl: LikeControl!

    // MARK: - Private Properties

    let photoCacheService = PhotoCacheService()

    // MARK: - Public Methods

    func configure(imageURLName: String, likesCount: Int, isLiked: Bool) {
        likeControl.likeCount = likesCount
        likeControl.isLiked = isLiked
        photoCacheService.photo(byUrl: imageURLName) { [weak self] image in
            self?.userPhotoImageView.image = image
        }
    }
}
