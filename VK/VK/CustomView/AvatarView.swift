// AvatarView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Custom AvatarView
final class AvatarView: UIView {
    // MARK: - Public Properties

    var image: UIImage? {
        didSet {
            avatarImageView.image = image
        }
    }

    lazy var avatarImageView = {
        let imageView = UIImageView()
        imageView.frame = bounds
        imageView.layer.cornerRadius = bounds.width / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBlue
        return imageView
    }()

    // MARK: - Private IBInspectable Properties

    @IBInspectable private var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable private var shadowOpacity: Float = 0.8 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable private var shadowRadius: CGFloat = 5 {
        didSet {
            layer.shadowRadius = shadowRadius
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

    // MARK: - Private Methods

    private func setupUI() {
        addSubview(avatarImageView)
        layer.cornerRadius = bounds.width / 2
        layer.shadowColor = UIColor.systemOrange.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}
