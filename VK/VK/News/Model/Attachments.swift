// Attachments.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// News attachments
struct Attachments: Decodable {
    /// Attachments type
    let type: String?
    /// Photo type attachments
    let photo: AttachmentsPhoto?
}
