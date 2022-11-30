// UserPhotosViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// All user photos
final class UserPhotosViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyText = ""
        static let oneIndices = 1
        static let twoIndices = 2
        static let defaultValue = 0
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var currentImageView: UIImageView!
    @IBOutlet private var nextImageView: UIImageView!
    @IBOutlet private var previousImageView: UIImageView!

    // MARK: - Private Visual Components

    private var toRightViewPropertyAnimator = UIViewPropertyAnimator()
    private var toLeftViewPropertyAnimator = UIViewPropertyAnimator()
    private var appearViewPropertyAnimator = UIViewPropertyAnimator()

    // MARK: - Public Properties

    var userPhotos: [Photo] = []

    // MARK: - Private Properties

    private var currentImageIndex = 1
    private var nextImageIndex = 2
    private var previousImageIndex = 0

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImages()
        setupPanGestureRecognizer()
    }

    // MARK: - @objc Private Methods

    @objc private func viewPannedAction(_ recognizer: UIPanGestureRecognizer) {
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

            toRightViewPropertyAnimator.addCompletion { [weak self] _ in
                self?.previousImageView.image = self?.currentImageView.image
                self?.currentImageView.image = self?.nextImageView.image
                self?.currentImageIndex += 1
                if self?.currentImageIndex == self?.userPhotos.count {
                    self?.currentImageIndex = 0
                }
                self?.calculateIndices()
                self?.nextImageView.loadImage(
                    urlName:
                    self?.userPhotos[self?.nextImageIndex ?? Constants.defaultValue].photoURLName
                        ?? Constants.emptyText
                )

                self?.currentImageView.transform = .identity
                self?.nextImageView.transform = .identity
                self?.nextImageView.alpha = 0
            }

            toLeftViewPropertyAnimator.addCompletion { [weak self] _ in
                self?.nextImageView.image = self?.currentImageView.image
                self?.currentImageView.image = self?.previousImageView.image
                self?.currentImageIndex -= 1
                if self?.currentImageIndex ?? 0 < 0 {
                    self?.currentImageIndex =
                        (self?.userPhotos.count ?? Constants.defaultValue) - Constants.oneIndices
                }
                self?.calculateIndices()
                self?.previousImageView.loadImage(
                    urlName:
                    self?.userPhotos[
                        self?.previousImageIndex
                            ?? Constants.defaultValue
                    ].photoURLName
                        ?? Constants.emptyText
                )
                self?.currentImageView.transform = .identity
                self?.currentImageView.alpha = 1
                self?.previousImageView.transform = .identity
            }

        default: break
        }
    }

    private func setupPanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(viewPannedAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }

    private func setupImages() {
        currentImageView.image = UIImage(
            named: userPhotos[currentImageIndex].photoURLName
        )
        nextImageView.loadImage(
            urlName: userPhotos[nextImageIndex].photoURLName
        )

        previousImageView.loadImage(
            urlName: userPhotos[previousImageIndex].photoURLName
        )

        nextImageView.alpha = 0
    }

    private func calculateIndices() {
        switch currentImageIndex {
        case 0:
            previousImageIndex = (userPhotos.count) - Constants.oneIndices
            nextImageIndex = 1
        case (userPhotos.count) - Constants.oneIndices:
            previousImageIndex = (userPhotos.count) - Constants.twoIndices
            nextImageIndex = 0
        default:
            previousImageIndex = currentImageIndex - 1
            nextImageIndex = currentImageIndex + 1
        }
    }
}
