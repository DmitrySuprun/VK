// NewsFeedGroup.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Profiles user of news provider
struct NewsFeedGroup: Decodable {
    /// Groups ID
    let id: Int
    /// Groups name
    let name: String
    /// Groups screen name
    let screenName: String
    /// Groups avatar photo url name
    let photo: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case photo = "photo_100"
    }
}
