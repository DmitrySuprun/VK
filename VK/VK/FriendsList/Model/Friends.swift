// Friends.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Friends info
struct Friends: Decodable {
    let response: Response

    struct Response: Decodable {
        let items: [Friend]
    }
}

/// Friend info
final class Friend: Object, Decodable {
    @Persisted var id: Int
    @Persisted var photo: String
    @Persisted var firstName: String
    @Persisted var lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
