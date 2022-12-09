// Likes.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Likes info
struct Likes: Decodable {
    /// Likes count
    let count: Int
    /// Is user likes current content
    let isUserLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case isUserLikes = "user_likes"
    }
}
