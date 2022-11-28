// UserPhotosCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User all photos collection
final class UserPhotosCollectionViewController: UICollectionViewController {
    // MARK: - Constants

    private enum Constants {
        static let userPhotosCollectionViewCellID = "userPhotosCollectionViewCellID"
        static let photoViewControllerSegueID = "photoViewControllerSegueID"
        static let defaultIntValue = 0
        static let defaultStringValue = ""
        static let defaultBoolValue = false
    }

    // MARK: - Public Properties

    var userID: Int?
    var photos: ResponseAllPhotos?

    // MARK: - Private Properties

    private let networkService = NetworkService()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.photoViewControllerSegueID,
              let photoViewController = segue.destination as? UserPhotosViewController
        else { return }
        photoViewController.userPhotos = photos
    }

    // MARK: - Private Methods

    private func fetchData() {
        networkService.fetchAllUserPhotos(userID: userID ?? 0) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(photos):
                self.photos = photos
            case let .failure(error):
                print(error)
            }
            self.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos?.photos.count ?? 0
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
            imageName: photos?.photos[indexPath.row].photoURLName ?? Constants.defaultStringValue,
            likesCount: photos?.photos[indexPath.row].likesCount ?? Constants.defaultIntValue,
            isLiked: photos?.photos[indexPath.row].isLike ?? Constants.defaultBoolValue
        )
        return cell
    }
}
