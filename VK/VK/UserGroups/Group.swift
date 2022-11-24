// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
/// Group info
struct Group {
    let name: String
    let imageName: String
}

/// Group info
struct Groups: Decodable {
    let response: Response

    struct Response: Decodable {
        let items: [Items]
    }

    struct Items: Decodable {
        let id: Int
        let photo: String
        let name: String

        enum CodingKeys: String, CodingKey {
            case id
            case photo = "photo_100"
            case name
        }
    }
}
