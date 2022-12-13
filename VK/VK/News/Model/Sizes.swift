// Sizes.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Photo sizes
struct Sizes: Decodable {
    /// Type of photo size
    let type: String
    /// Photo url
    let url: String
    /// Photo height
    let height: Int
    /// Photo width
    let width: Int
    /// Photo size ratio
    var aspectRatio: CGFloat {
        CGFloat(height) / CGFloat(width)
    }
}
