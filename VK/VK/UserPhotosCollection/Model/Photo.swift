// Photo.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Photo info
final class Photo: Object {
    @Persisted(primaryKey: true) var photoURLName: String
    @Persisted var ownerID: Int
    @Persisted var likesCount: Int
    @Persisted var isLike: Bool
}
