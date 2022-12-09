// ResponseNewsFeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Response News
struct ResponseNewsFeed: Decodable {
    // MARK: - Private CodingKeys

    private enum ResponseCodingKeys: String, CodingKey {
        case response
    }

    private enum NewsFeedsCodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
    }

    // MARK: - Public Properties

    let newsFeedItems: [NewsFeedItem]
    let newsFeedProfiles: [NewsFeedProfile]
    let newsFeedGroups: [NewsFeedGroup]

    // MARK: - Initializers

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        let responseNestedContainer = try
            container.nestedContainer(keyedBy: NewsFeedsCodingKeys.self, forKey: .response)
        newsFeedItems = try responseNestedContainer.decode(
            [NewsFeedItem].self,
            forKey: .items
        )
        newsFeedProfiles = try responseNestedContainer.decode(
            [NewsFeedProfile].self,
            forKey: .profiles
        )
        newsFeedGroups = try responseNestedContainer.decode(
            [NewsFeedGroup].self,
            forKey: .groups
        )
    }
}
