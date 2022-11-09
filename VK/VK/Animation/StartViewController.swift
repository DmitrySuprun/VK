// StartViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// StartVC with animation
final class StartViewController: UIViewController {
    // MARK: - Life Cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withDuration: 2)
    }

    // MARK: - Private Methods

    private func performSegue(withDuration: UInt32) {
        sleep(withDuration)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "loginViewControllerID")
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
}
