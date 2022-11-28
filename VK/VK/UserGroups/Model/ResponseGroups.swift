// ResponseGroups.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Groups information
struct ResponseGroups: Decodable {
    // MARK: - Private CodingKeys

    private enum ResponseCodingKeys: String, CodingKey {
        case response
    }

    private enum GroupsCodingKeys: String, CodingKey {
        case groups = "items"
    }

    // MARK: - Public Properties

    let groups: [Group]

    // MARK: - Initializers

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        let responseNestedContainer = try container.nestedContainer(keyedBy: GroupsCodingKeys.self, forKey: .response)
        groups = try responseNestedContainer.decode([Group].self, forKey: .groups)
    }
}
