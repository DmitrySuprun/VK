// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Groups information
struct Groups: Decodable {
    let response: Response

    struct Response: Decodable {
        let groups: [Group]

        enum CodingKeys: String, CodingKey {
            case groups = "items"
        }
    }
}

/// Group information
final class Group: Object, Decodable {
    @Persisted var id: Int
    @Persisted var photo: String
    @Persisted var name: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_100"
        case name
    }
}
