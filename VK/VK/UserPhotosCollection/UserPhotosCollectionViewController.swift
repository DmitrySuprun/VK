// UserPhotosCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User all photos collection
final class UserPhotosCollectionViewController: UICollectionViewController {
    // MARK: - Constants

    private enum Constants {
        static let userPhotosCollectionViewCellID = "userPhotosCollectionViewCellID"
    }

    // MARK: - Public Properties

    var friendsInfo: [FriendsInfo] = []

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        friendsInfo.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.userPhotosCollectionViewCellID,
            for: indexPath
        ) as? UserPhotoCollectionViewCell
        else { return UserPhotoCollectionViewCell() }
        cell.configure(
            imageName: friendsInfo[indexPath.row].avatarName,
            likesCount: friendsInfo[indexPath.row].likesCount
        )
        return cell
    }
}
