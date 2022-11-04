// AvatarView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Custom AvatarView
class AvatarView: UIView {
    // MARK: - IBInspectable Properties

    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable var shadowOpacity: Float = 0.8 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 5 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    // MARK: - Private Properties

    private lazy var avatarImageView = {
        let imageView = UIImageView()
        imageView.frame = bounds
        imageView.layer.cornerRadius = bounds.width / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBlue
        return imageView
    }()

    // MARK: - Public Properties

    var image: UIImage? {
        didSet {
            avatarImageView.image = image
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Private Properties

    private func setupUI() {
        addSubview(avatarImageView)
        layer.cornerRadius = bounds.width / 2
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}
