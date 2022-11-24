// UserAllPhotos.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// All user photos with additional info
struct Photos: Decodable {
    let response: Response

    struct Response: Decodable {
        let items: [Item]
    }

    struct Item: Decodable {
        let sizes: [Sizes]
        let likes: Likes
    }
}

final class Sizes: Object, Decodable {
    @Persisted var url: String
}

final class Likes: Object, Decodable {
    @Persisted var count: Int
}
