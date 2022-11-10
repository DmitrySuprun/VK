// PopViewControllerAnimatedTransitioning.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// PopViewController animation
class PopViewControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Private Methods

    let timeInterval = 0.5

    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        timeInterval
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.view(forKey: .from),
              let destination = transitionContext.view(forKey: .to)
        else { return }
        destination.alpha = 0

        let viewHeight = transitionContext.containerView.frame.height
        let viewWidth = transitionContext.containerView.frame.width

        transitionContext.containerView.addSubview(destination)
        destination.frame = transitionContext.containerView.frame

        source.frame = transitionContext.containerView.frame
        UIView.animate(withDuration: timeInterval, delay: 0, options: .curveEaseIn) {
            source.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
                .concatenating(CGAffineTransform(translationX: viewHeight / 2 + viewWidth / 2, y: -viewWidth / 2))

            destination.alpha = 1
            destination.layer.cornerRadius = 0
            source.alpha = 0

        } completion: { completed in
            transitionContext.completeTransition(completed)
        }
    }
}
