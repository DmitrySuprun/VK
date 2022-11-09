// UserPhotosViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// All user photos
final class UserPhotosViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var currentImageView: UIImageView!
    @IBOutlet var nextImageView: UIImageView!
    @IBOutlet var previousImageView: UIImageView!

    // MARK: - Private Visual Components

    private var toRightViewPropertyAnimator = UIViewPropertyAnimator()
    private var toLeftViewPropertyAnimator = UIViewPropertyAnimator()
    private var appearViewPropertyAnimator = UIViewPropertyAnimator()

    // MARK: - Public Properties

    var userInfo: UserInfo!

    // MARK: - Private Properties

    private var currentImageIndex = 1
    private var nextImageIndex = 2
    private var previousImageIndex = 0

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImages()
        setupUI()
    }

    // MARK: - Public Methods

    func configure(user: UserInfo) {
        userInfo = user
    }

    // MARK: - @objc Private Methods

    @objc private func viewPanned(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            let distanceAnimation = view.frame.width / 2 + currentImageView.frame.width / 2

            toRightViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut, animations: {
                self.currentImageView.transform = CGAffineTransform(translationX: distanceAnimation, y: 0)
            })

            toLeftViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut, animations: {
                self.previousImageView.transform = CGAffineTransform(translationX: -distanceAnimation, y: 0)
                self.currentImageView.alpha = 0
                self.currentImageView.transform = CGAffineTransform(scaleX: 0.42, y: 0.42)
            })

            appearViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut, animations: {
                self.nextImageView.alpha = 1
                self.nextImageView.transform = CGAffineTransform(scaleX: 2.4, y: 2.4)
            })

        case .changed:
            let panDistance = recognizer.translation(in: view).x / 200

            if panDistance > 0 {
                toRightViewPropertyAnimator.fractionComplete = panDistance
                appearViewPropertyAnimator.fractionComplete = panDistance
            } else {
                toLeftViewPropertyAnimator.fractionComplete = -panDistance
            }

        case .ended:
            toLeftViewPropertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 1)
            toRightViewPropertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 1)
            appearViewPropertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 1)

            toRightViewPropertyAnimator.addCompletion { _ in
                self.previousImageView.image = self.currentImageView.image
                self.currentImageView.image = self.nextImageView.image
                self.currentImageIndex += 1
                if self.currentImageIndex == self.userInfo.imagesNames.count {
                    self.currentImageIndex = 0
                }
                self.calculatePreviousNextIndex()
                self.nextImageView.image = UIImage(named: self.userInfo.imagesNames[self.nextImageIndex])
                self.currentImageView.transform = .identity
                self.nextImageView.transform = .identity
                self.nextImageView.alpha = 0
            }

            toLeftViewPropertyAnimator.addCompletion { _ in
                self.nextImageView.image = self.currentImageView.image
                self.currentImageView.image = self.previousImageView.image
                self.currentImageIndex -= 1
                if self.currentImageIndex < 0 {
                    self.currentImageIndex = self.userInfo.imagesNames.count - 1
                }
                self.calculatePreviousNextIndex()
                self.previousImageView.image = UIImage(named: self.userInfo.imagesNames[self.previousImageIndex])
                self.currentImageView.transform = .identity
                self.currentImageView.alpha = 1
                self.previousImageView.transform = .identity
            }

        default: break
        }
    }

    // MARK: - Private Methods

    private func setupUI() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }

    private func setupImages() {
        currentImageView.image = UIImage(
            named: userInfo.imagesNames[currentImageIndex]
        )
        nextImageView.image = UIImage(
            named: userInfo.imagesNames[nextImageIndex]
        )
        previousImageView.image = UIImage(
            named: userInfo.imagesNames[previousImageIndex]
        )
        nextImageView.alpha = 0
    }

    private func calculatePreviousNextIndex() {
        switch currentImageIndex {
        case 0:
            previousImageIndex = userInfo.imagesNames.count - 1
            nextImageIndex = 1
        case userInfo.imagesNames.count - 1:
            previousImageIndex = userInfo.imagesNames.count - 2
            nextImageIndex = 0
        default:
            previousImageIndex = currentImageIndex - 1
            nextImageIndex = currentImageIndex + 1
        }
    }
}
