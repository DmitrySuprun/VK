// ViewController+extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Show alert
extension LoginViewController {
    // MARK: - Constants

    private enum AlertConstants {
        static let errorText = "Error"
        static let wrongPasswordText = "Wrong Password"
        static let okText = "Ok"
    }

    // MARK: - Public Methods

    func showLoginError() {
        let alertWrongPassword = UIAlertController(
            title: AlertConstants.errorText,
            message: AlertConstants.wrongPasswordText,
            preferredStyle: .alert
        )
        let okButton = UIAlertAction(title: AlertConstants.okText, style: .default, handler: nil)
        alertWrongPassword.addAction(okButton)
        present(alertWrongPassword, animated: true, completion: nil)
    }
}
