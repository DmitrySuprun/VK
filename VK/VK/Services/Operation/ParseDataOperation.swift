// ParseDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Operation for parsing response data
final class ParseDataOperation: Operation {
    // MARK: - Public Properties

    var outputData: [Group] = []

    // MARK: - Public Methods

    override func main() {
        guard let dataOperation = dependencies.first as? GetDataOperation,
              let data = dataOperation.data
        else { return }

        do {
            let response = try JSONDecoder().decode(ResponseGroups.self, from: data)
            outputData = response.groups
        } catch {
            print(#function)
            print(error.localizedDescription)
        }
    }
}
