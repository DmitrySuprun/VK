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

    var userID: Int?
    var usersPhotos: Photos?

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
        photoViewController.userPhotos = usersPhotos
    }

    // MARK: - Private Methods

    private func fetchData() {
        networkService.fetchAllUserPhotos(userID: userID ?? 0) { [weak self] result in
            switch result {
            case let .success(photos): self?.usersPhotos = photos
            case let .failure(error): print(error)
            }
            self?.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        usersPhotos?.response.items.count ?? 0
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
            imageName: usersPhotos?.response.items[indexPath.row].sizes.last?.url ?? "",
            likesCount: usersPhotos?.response.items[indexPath.row].likes.count ?? 0
        )
        return cell
    }
}
