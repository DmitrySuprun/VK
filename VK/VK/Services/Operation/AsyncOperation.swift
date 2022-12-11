// AsyncOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Common class for NetworkRequest
class AsyncOperation: Operation {
    // MARK: - Operation State

    enum State: String {
        case isReady, executing, finished

        fileprivate var keyPath: String {
            "is\(rawValue.capitalized)"
        }
    }

    // MARK: - Public Properties

    override var isAsynchronous: Bool {
        true
    }

    override var isReady: Bool {
        super.isReady && state == .isReady
    }

    override var isExecuting: Bool {
        state == .executing
    }

    override var isFinished: Bool {
        state == .finished
    }

    var state = State.isReady {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }

    // MARK: - Public Methods

    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }

    override func cancel() {
        super.cancel()
        state = .finished
    }
}
