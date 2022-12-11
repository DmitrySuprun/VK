// GetDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Common Operation for gettin data
final class GetDataOperation: AsyncOperation {
    // MARK: - Public Properties

    var data: Data?

    // MARK: - Private Properties

    var request: DataRequest?

    // MARK: - Initializer

    init(request: DataRequest) {
        self.request = request
    }

    // MARK: - Public Methods

    override func cancel() {
        request?.cancel()
        super.cancel()
    }

    override func main() {
        request?.responseData(queue: DispatchQueue.global()) { [weak self] responseData in
            guard let self else { return }
            self.data = responseData.data
            self.state = .finished
        }
    }
}
