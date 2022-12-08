// Attachments.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// News attachments
struct Attachments: Decodable {
    /// attachments type
    let type: String?
    /// photo type attachments
    let photo: AttachmentsPhoto?
}
