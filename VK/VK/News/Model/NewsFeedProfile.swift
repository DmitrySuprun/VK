// NewsFeedProfile.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Profiles user of news provider
struct NewsFeedProfile: Decodable {
    /// ID user
    let id: Int
    /// Avatar photo url
    let photo: String
    /// User First Name
    let firstName: String
    /// User Last Name
    let lastName: String
    /// User Full Name
    var fullName: String {
        "\(firstName) \(lastName)"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
