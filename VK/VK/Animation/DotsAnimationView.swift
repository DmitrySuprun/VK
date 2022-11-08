// DotsAnimationView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// View with three dots animation
final class DotsAnimationView: UIView {
    // MARK: - Private Visual Components

    private let dot1 = UIView()
    private let dot2 = UIView()
    private let dot3 = UIView()
    private let hStack = UIStackView()

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        frame.size = CGSize(width: 130, height: 30)
        guard let superviewCenter = superview?.center else { return }
        center = superviewCenter

        addSubview(hStack)
        hStack.axis = .horizontal
        hStack.spacing = 20
        hStack.distribution = .fillEqually
        hStack.frame = CGRect(origin: .zero, size: frame.size)

        setupView(view: dot1)
        setupView(view: dot2)
        setupView(view: dot3)
        hStack.addArrangedSubview(dot1)
        hStack.addArrangedSubview(dot2)
        hStack.addArrangedSubview(dot3)
        flashAnimation(view: dot1, startDelay: 0)
        flashAnimation(view: dot2, startDelay: 0.3)
        flashAnimation(view: dot3, startDelay: 0.6)
    }

    private func setupView(view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = frame.height / 2
        view.backgroundColor = .systemBlue
    }

    private func flashAnimation(view: UIView, startDelay: Double) {
        let animation = CABasicAnimation(keyPath: #keyPath(UIView.backgroundColor))
        animation.beginTime = CACurrentMediaTime() + startDelay
        animation.fromValue = UIColor.systemBlue.cgColor
        animation.toValue = UIColor.white.cgColor
        animation.duration = 0.6
        animation.repeatCount = 10
        animation.autoreverses = true
        view.layer.add(animation, forKey: nil)
    }
}
