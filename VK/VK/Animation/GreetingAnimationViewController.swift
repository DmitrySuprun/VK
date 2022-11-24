// GreetingAnimationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Greeting with tree dots animation
final class GreetingAnimationViewController: UIViewController {
    // MARK: - Private Constants

    private struct Constants {
        static let loginViewControllerID = "loginViewControllerID"
        static let mainStoryboardName = "Main"
    }

    // MARK: - Life Cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withDuration: 2)
    }

    // MARK: - Private Methods

    private func performSegue(withDuration: UInt32) {
        sleep(withDuration)
        let storyboard = UIStoryboard(name: Constants.mainStoryboardName, bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: Constants.loginViewControllerID)
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
}
