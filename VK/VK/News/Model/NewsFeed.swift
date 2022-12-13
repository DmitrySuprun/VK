// NewsFeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// NewsFeed info contains News owner
struct NewsFeed: Decodable {
    private enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }

    /// NewsFeed list
    var items: [NewsFeedItem]
    /// NewsFeed owner User list
    var profiles: [User]
    /// NewsFeed owner Group list
    var groups: [Group]
    /// Next NewsFeed request ID
    let nextFrom: String?
}
