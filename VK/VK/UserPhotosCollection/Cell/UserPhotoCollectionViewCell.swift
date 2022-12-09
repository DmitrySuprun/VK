// UserPhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User Single ImagePost
final class UserPhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutletsz

    @IBOutlet private var userPhotoImageView: UIImageView!
    @IBOutlet private var likeControl: LikeControl!

    // MARK: - Public Methods

    func configure(imageURLName: String, likesCount: Int, isLiked: Bool, networkService: NetworkService) {
        likeControl.likeCount = likesCount
        likeControl.isLiked = isLiked
        networkService.loadImage(urlName: imageURLName) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                guard let data else { return }
                self.userPhotoImageView.image = UIImage(data: data)
            case let .failure(error):
                print(#function, error)
            }
        }
    }
}
