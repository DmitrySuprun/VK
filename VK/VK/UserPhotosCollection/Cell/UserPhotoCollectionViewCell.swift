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
        fetchImage(imageURLName: imageURLName)
    }

    // MARK: - Private Methods

    private func fetchImage(imageURLName: String) {
        photoCacheService.photo(byUrl: imageURLName) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(image):
                self.userPhotoImageView.image = image
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
