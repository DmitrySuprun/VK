// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import PromiseKit
import UIKit

/// User authentication
final class LoginViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let tabBarID = "tabBarID"
        static let storyboardMainName = "Main"
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var backgroundScrollView: UIScrollView!
    @IBOutlet private var loadingActivityIndicatorView: UIActivityIndicatorView!

    // MARK: - Private Properties

    let authService = AuthService()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }

    // MARK: - Private IBAction Methods

    @IBAction private func enterButtonAction(_ sender: Any) {
        firstly {
            self.loadingActivityIndicatorView.isHidden = false
            self.loadingActivityIndicatorView.startAnimating()
            return authService.isValidAuthData(login: loginTextField.text, password: passwordTextField.text)
        }.done { isValidAuthentication in
            if isValidAuthentication {
                let storyBoard = UIStoryboard(name: Constants.storyboardMainName, bundle: nil)
                let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarID)
                tabBarViewController.modalPresentationStyle = .fullScreen
                self.present(tabBarViewController, animated: true)
            } else {
                self.showLoginError()
            }
        }.catch { error in
            print(error.localizedDescription)
        }
    }

    // MARK: - Objc Private Methods

    @objc private func keyboardWasShownAction(notification: Notification) {
        let info = notification.userInfo as? NSDictionary
        let keyboardSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize?.height ?? 0, right: 0.0)
        backgroundScrollView?.contentInset = contentInsets
        backgroundScrollView?.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillBeHiddenAction(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        backgroundScrollView?.contentInset = contentInsets
    }

    @objc private func hideKeyboardAction() {
        backgroundScrollView?.endEditing(true)
    }

    // MARK: - IBAction

    @IBAction private func loginButton(_ sender: Any) {}

    // MARK: - Private Methods

    private func setupUI() {
        loadingActivityIndicatorView.isHidden = true
        let hideKeyboardGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        backgroundScrollView.addGestureRecognizer(hideKeyboardGestureRecognizer)
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWasShownAction),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHiddenAction(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}
