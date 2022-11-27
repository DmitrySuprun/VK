// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Information about current session
final class Session {
    // MARK: - Class Properties

    static var shared = Session()

    // MARK: - Public Properties

    var userID: Int?
    var token: String?

    // MARK: - Private Initializer

    private init() {}
}
