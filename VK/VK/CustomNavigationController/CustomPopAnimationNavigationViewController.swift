// CustomPopAnimationNavigationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// NavigationViewController with custom pop animation
final class CustomPopAnimationNavigationViewController: UINavigationController {
    // MARK: - Private Properties

    private let interactiveTransition = CustomInteractiveTransition()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

// MARK: - UINavigationControllerDelegate

extension CustomPopAnimationNavigationViewController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.hasStarted ? interactiveTransition : nil
    }

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation:
        UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            interactiveTransition.viewController = toVC
            return PushViewControllerAnimatedTransitioning()

        case .pop:
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return PopViewControllerAnimatedTransitioning()

        case .none:
            return nil
        @unknown default:
            return nil
        }
    }
}
