// ResponseFriends.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Response Friends
struct ResponseFriends: Decodable {
    // MARK: - Private CodingKeys

    private enum ResponseCodingKeys: String, CodingKey {
        case response
    }

    private enum FriendsCodingKeys: String, CodingKey {
        case friends = "items"
    }

    // MARK: - Public Properties

    let friends: [Friend]

    // MARK: - Initializers

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        let responseNestedContainer = try
            container.nestedContainer(keyedBy: FriendsCodingKeys.self, forKey: .response)
        friends = try responseNestedContainer.decode([Friend].self, forKey: .friends)
    }
}
