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
    var photos: [Photo] = []

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private let dataBaseService = DatabaseService()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.photoViewControllerSegueID,
              let photoViewController = segue.destination as? UserPhotosViewController
        else { return }
        photoViewController.userPhotos = photos
    }

    // MARK: - Private Methods

    private func loadData() {
        fetchData()
        guard let savedPhotos = dataBaseService.loadData(objectType: Photo.self) else { return }
        photos = savedPhotos.filter { $0.ownerID == self.userID }
        collectionView.reloadData()
    }

    private func saveData(data: [Photo]) {
        dataBaseService.saveData(objects: data)
    }

    private func fetchData() {
        networkService.fetchAllUserPhotos(userID: userID ?? 0) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(responsePhotos):
                self.saveData(data: responsePhotos.photos)
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
        photos.count
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
            imageName: photos[indexPath.row].photoURLName,
            likesCount: photos[indexPath.row].likesCount,
            isLiked: photos[indexPath.row].isLike
        )
        return cell
    }
}
