// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Group info
struct Group {
    let name: String
    let imageName: String
}

/// Group info
struct Groups: Decodable {
    let response: Response

    struct Response: Decodable {
        let items: [GroupsItems]
    }
}

/// Realm object
final class GroupsItems: Object, Decodable {
    @Persisted var id: Int
    @Persisted var photo: String
    @Persisted var name: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_100"
        case name
    }
}
