// NewsFeedItem.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// News
struct NewsFeedItem: Decodable {
    let date: Int
    let id: Int?
    let ownerID: Int?
    let text: String?
    let attachments: [Attachments]?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case date
        case id
        case ownerID = "owner_id"
        case text
        case attachments
        case comments
        case likes
        case reposts
        case views
        case type
    }

    struct Attachments: Decodable {
        let type: String?
        let photo: Photo?
    }

    struct Photo: Decodable {
        let sizes: [Sizes]
    }

    struct Sizes: Decodable {
        let type: String
        let url: String
    }

    struct Comments: Decodable {
        let count: Int
    }

    struct Likes: Decodable {
        let count: Int
        let isUserLikes: Int

        enum CodingKeys: String, CodingKey {
            case count
            case isUserLikes = "user_likes"
        }
    }

    struct Reposts: Decodable {
        let count: Int
    }

    struct Views: Decodable {
        let count: Int
    }
}
