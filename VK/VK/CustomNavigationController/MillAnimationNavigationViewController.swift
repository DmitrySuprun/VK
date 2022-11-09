// MillAnimationNavigationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// NavigationViewController with custom push pop animation
final class MillAnimationNavigationViewController: UINavigationController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

// MARK: - UINavigationControllerDelegate

extension MillAnimationNavigationViewController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop: return PopViewControllerAnimatedTransitioning()
        case .push: return PushViewControllerAnimatedTransitioning()
        case .none: return nil
        @unknown default: return nil
        }
    }
}
