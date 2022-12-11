// ParseDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Operation for parsing response data
final class ParseDataOperation: Operation {
    // MARK: - Public Properties

    var groups: [Group] = []

    // MARK: - Public Methods

    override func main() {
        guard let dataOperation = dependencies.first as? GetDataOperation,
              let data = dataOperation.data
        else { return }

        do {
            let response = try JSONDecoder().decode(ResponseGroups.self, from: data)
            groups = response.groups
        } catch {
            print(error.localizedDescription)
        }
    }
}
