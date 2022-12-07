// NewsButtonsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Button for display and manage reactions and status of news
final class NewsButtonsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var likeButton: UIButton!
    @IBOutlet var commentsButton: UIButton!
    @IBOutlet var shareButton: UIButton!

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
