// Group.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Group information
final class Group: Object, Decodable {
    // MARK: - Private CodingKeys

    private enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_100"
        case name
    }

    // MARK: - @Persisted Properties

    @Persisted(primaryKey: true) var id: Int
    @Persisted var photo: String
    @Persisted var name: String
}
