// AuthService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import PromiseKit

/// Authentication service
class AuthService {
    // MARK: - Constants

    enum Constants {
        static let loginText = "1"
        static let passwordText = "1"
    }

    // MARK: - Public Properties

    func isValidAuthData(login: String?, password: String?) -> Promise<Bool> {
        Promise<Bool> { resolver in
            DispatchQueue.global().async {
                sleep(1)
                if login == Constants.loginText, password == Constants.passwordText {
                    resolver.fulfill(true)
                } else {
                    resolver.fulfill(false)
                }
            }
        }
    }
}
