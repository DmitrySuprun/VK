// DotsAnimationView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// View with three dots animation
final class DotsAnimationView: UIView {
    // MARK: - Private Visual Components

    private let firstDotView = UIView()
    private let middleDotView = UIView()
    private let lastDotView = UIView()
    private let dotsHorizontalStackView = UIStackView()

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

        addSubview(dotsHorizontalStackView)
        dotsHorizontalStackView.axis = .horizontal
        dotsHorizontalStackView.spacing = 20
        dotsHorizontalStackView.distribution = .fillEqually
        dotsHorizontalStackView.frame = CGRect(origin: .zero, size: frame.size)

        setupView(view: firstDotView)
        setupView(view: middleDotView)
        setupView(view: lastDotView)
        dotsHorizontalStackView.addArrangedSubview(firstDotView)
        dotsHorizontalStackView.addArrangedSubview(middleDotView)
        dotsHorizontalStackView.addArrangedSubview(lastDotView)
        flashAnimation(view: firstDotView, startDelay: 0)
        flashAnimation(view: middleDotView, startDelay: 0.3)
        flashAnimation(view: lastDotView, startDelay: 0.6)
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
