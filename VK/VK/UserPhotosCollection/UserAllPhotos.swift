// UserAllPhotos.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// All user photos with additional info
struct Photos: Decodable {
    let response: Response

    struct Response: Decodable {
        let items: [Items]
    }

    struct Items: Decodable {
        let sizes: [Sizes]
        let likes: Likes
    }

    struct Sizes: Decodable {
        let url: String
    }

    struct Likes: Decodable {
        let count: Int
    }
}
