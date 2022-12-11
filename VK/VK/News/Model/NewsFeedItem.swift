// NewsFeedItem.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// News info
struct NewsFeedItem: Decodable {
    private enum CodingKeys: String, CodingKey {
        case date
        case id
        case ownerID = "owner_id"
        case sourceID = "source_id"
        case text
        case attachments
        case comments
        case likes
        case reposts
        case views
        case type
        case photos
    }

    /// News date
    let date: Int
    /// News ID
    let id: Int?
    /// News owner ID
    let ownerID: Int?
    /// News source ID
    let sourceID: Int?
    /// News text
    let text: String?
    /// News attachments list
    let attachments: [Attachments]?
    /// News comments info
    let comments: Comments?
    /// News likes info
    let likes: Likes?
    /// News reposts info
    let reposts: Reposts?
    /// News views info
    let views: Views?
    /// News type
    let type: String
    /// News photo type photos
    let photos: Photos?
}
