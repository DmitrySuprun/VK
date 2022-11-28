// Photo.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Photo info
final class Photo: Object {
    @Persisted var photoURLName: String
    @Persisted var likesCount: Int
    @Persisted var isLike: Bool
}
