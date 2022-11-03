// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Group Info
class GroupTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var groupsImageView: UIImageView!
    @IBOutlet private var groupsNameLabel: UILabel!

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Public Properties

    func configure(nameLabelText: String, groupsImageName: String) {
        groupsNameLabel.text = nameLabelText
        groupsImageView.image = UIImage(named: groupsImageName)
    }
}
