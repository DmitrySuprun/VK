// CustomInteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Custom animation closing ViewController
final class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Public Properties

    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(handleScreenEdgeGestureAction(_:))
            )
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }

    var isStarted: Bool = false
    var isFinished: Bool = false

    // MARK: - Private Methods

    @objc private func handleScreenEdgeGestureAction(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            isStarted = true
            viewController?.navigationController?.popViewController(animated: true)

        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.y / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            isFinished = progress > 0.33
            update(progress)

        case .ended:
            isStarted = false
            if isFinished {
                finish()
            } else {
                cancel()
            }
        case .cancelled:
            isStarted = false
            cancel()

        default: return
        }
    }
}
