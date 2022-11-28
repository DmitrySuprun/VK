// Array+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Safety index handling
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
