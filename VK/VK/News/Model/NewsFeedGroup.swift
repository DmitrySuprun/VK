// NewsFeedGroup.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// News
struct NewsFeedGroup: Decodable {
    let id: Int
    let name: String
    let screenName: String
    let type: String
    let photo: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case type
        case photo = "photo_100"
    }
}
