// NewsFeedProfile.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// News
struct NewsFeedProfile: Decodable {
    let id: Int
    let photo: String
    let firstName: String
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
