// SaveToDatabaseOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Operation Save To database
final class SaveToDatabaseOperation: Operation {
    // MARK: - Private Properties

    let databaseService = DatabaseService()

    // MARK: - Public Methods

    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation else { return }
        let groups = parseDataOperation.groups
        databaseService.save(objects: groups)
    }
}
