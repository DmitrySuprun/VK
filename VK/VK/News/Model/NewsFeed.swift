// NewsFeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// NewsFeed info contains News owner
struct NewsFeed: Decodable {
    /// NewsFeed list
    let items: [NewsFeedItem]
    /// NewsFeed owner User list
    let profiles: [User]
    /// NewsFeed owner Group list
    let groups: [Group]
}
