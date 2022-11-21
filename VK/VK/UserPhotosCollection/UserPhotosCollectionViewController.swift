// UserPhotosCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User all photos collection
final class UserPhotosCollectionViewController: UICollectionViewController {
    // MARK: - Constants

    private enum Constants {
        static let userPhotosCollectionViewCellID = "userPhotosCollectionViewCellID"
        static let photoViewControllerSegueID = "photoViewControllerSegueID"
    }

    // MARK: - Public Properties

    var usersInfo: [UserInfo] = []

    // MARK: - Public Properties

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.photoViewControllerSegueID,
              let photoViewController = segue.destination as? UserPhotosViewController
        else { return }
        photoViewController.userInfo = usersInfo.first
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        usersInfo.count
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
            imageName: usersInfo[indexPath.row].avatarName,
            likesCount: usersInfo[indexPath.row].likesCount
        )
        return cell
    }
}
