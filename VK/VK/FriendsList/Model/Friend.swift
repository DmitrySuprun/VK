// Friend.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Friend info
final class Friend: Object, Decodable {
    // MARK: - Private CodingKeys

    private enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }

    // MARK: - @Persisted Properties

    @Persisted(primaryKey: true) var id: Int
    @Persisted var photo: String
    @Persisted var firstName: String
    @Persisted var lastName: String
}
