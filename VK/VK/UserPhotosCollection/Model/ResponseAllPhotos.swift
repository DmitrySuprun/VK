// ResponseAllPhotos.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Response all photo
struct ResponseAllPhotos: Decodable {
    // MARK: - Constants

    private struct Constants {
        static let imageQualityKeyName = "x"
        static let isLikedIntValue = 0
    }

    // MARK: - Private Coding Keys

    private enum ResponseCodingKeys: String, CodingKey {
        case response
    }

    private enum ItemsCodingKeys: String, CodingKey {
        case items
    }

    private enum PhotosInfoCodingKeys: String, CodingKey {
        case id
        case sizes
        case likes
    }

    private enum LikesCodingKeys: String, CodingKey {
        case likesCount = "count"
        case userLikes = "user_likes"
    }

    private enum SizesCodingKeys: String, CodingKey {
        case url
        case type
    }

    // MARK: - Public Properties

    var photos: [Photo] = []

    // MARK: - Initializers

    init(from decoder: Decoder) throws {
        var photoURLName = ""
        var likesCount = 0
        var isLike = false

        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        let responseContainer = try container.nestedContainer(keyedBy: ItemsCodingKeys.self, forKey: .response)
        var items = try responseContainer.nestedUnkeyedContainer(forKey: .items)

        while !items.isAtEnd {
            let photosInfoContainer = try items.nestedContainer(keyedBy: PhotosInfoCodingKeys.self)

            let likesContainer =
                try photosInfoContainer.nestedContainer(keyedBy: LikesCodingKeys.self, forKey: .likes)
            likesCount = try likesContainer.decode(Int.self, forKey: .likesCount)

            let userLikes = try likesContainer.decode(Int.self, forKey: .userLikes)
            isLike = userLikes == Constants.isLikedIntValue ? true : false

            var sizes = try photosInfoContainer.nestedUnkeyedContainer(forKey: .sizes)
            while !sizes.isAtEnd {
                let size = try sizes.nestedContainer(keyedBy: SizesCodingKeys.self)
                let url = try size.decode(String.self, forKey: .url)
                let type = try size.decode(String.self, forKey: .type)
                guard type == Constants.imageQualityKeyName else { continue }
                photoURLName = url
            }

            let photo = Photo()
            photo.photoURLName = photoURLName
            photo.likesCount = likesCount
            photo.isLike = isLike
            photos.append(photo)
        }
    }
}
