// Photos.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
/// Photos
struct Photos: Decodable {
    /// Photos count
    let count: Int
    /// Photos list
    let items: [PhotosItems]
}
