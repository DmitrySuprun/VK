// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// User
struct User: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarImageURLName = "photo_100"
    }

    /// User ID
    let id: Int
    /// User first name
    let firstName: String
    /// User second name
    let lastName: String
    /// User avatar image path
    let avatarImageURLName: String
    /// User full name
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
