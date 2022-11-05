// LikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Control for display like count and change value
final class LikeControl: UIControl {
    // MARK: - Private Constants
    private enum Constants {
        static let likedImageName = "heart.fill"
        static let unLikesImageName = "heart"
    }
    
    // MARK: - Public Properties

    var likeCount = 0 {
        didSet {
            likeCountLabel.text = String(likeCount)
        }
    }

    var isLiked = true {
        didSet {
            likeCountLabel.text = String(likeCount)
            if isLiked {
                heartImageView.image = UIImage(systemName: Constants.unLikesImageName)
            } else {
                heartImageView.image = UIImage(systemName: Constants.likedImageName)
            }
        }
    }

    // MARK: - Private Properties

    private var heartImageView = UIImageView()
    private var likeCountLabel = UILabel()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    @objc private func touchUpInside() {
        let animation = CASpringAnimation(keyPath: #keyPath(CALayer.bounds))
        animation.fromValue = CGRect(
            x: 0,
            y: 0,
            width: heartImageView.bounds.width - 5,
            height: heartImageView.bounds.height - 5
        )
        animation.toValue = heartImageView.bounds
        animation.initialVelocity = 0.1
        animation.damping = 0.7
        animation.stiffness = 70
        animation.mass = 0.1
        animation.duration = 1
        heartImageView.layer.add(animation, forKey: nil)

        if isLiked {
            likeCount += 1
        } else {
            likeCount -= 1
        }
        isLiked.toggle()
        sendActions(for: .valueChanged)
    }

    // MARK: - Private Methods

    private func setupUI() {
        backgroundColor = UIColor.clear
        
        addSubview(heartImageView)
        addSubview(likeCountLabel)
        setupConstraints()
        
        likeCountLabel.textAlignment = .center
        likeCountLabel.textColor = .label

        heartImageView.image = isLiked ?
        UIImage(systemName: Constants.unLikesImageName) : UIImage(systemName: Constants.likedImageName)
        
        heartImageView.contentMode = .scaleAspectFit

        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false

        heartImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        heartImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
        heartImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        heartImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        likeCountLabel.leadingAnchor.constraint(equalTo: heartImageView.trailingAnchor).isActive = true
        likeCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        likeCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
