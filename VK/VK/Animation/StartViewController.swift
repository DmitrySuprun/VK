// StartViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// StartVC with animation
final class StartViewController: UIViewController {
    // MARK: - Life Cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(2)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loginViewControllerID")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
