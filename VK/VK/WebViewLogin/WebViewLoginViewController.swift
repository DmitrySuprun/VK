//
//  WebViewLoginViewController.swift
//  VK
//
//  Created by Дмитрий Супрун on 22.11.22.
//

import UIKit
import WebKit

/// Login VK with OAuth. Get token
final class WebViewLoginViewController: UIViewController {
    // MARK: - Private Constants
    
    private enum Constants {
        static let oAuthURLName = "https://oauth.vk.com/authorize?client_id=8090325&revoke=1&response_type=token&scope=friends,groups,photos"
        static let validPathName = "/blank.html"
        static let ampersandCharacterName = "&"
        static let equalCharacterName = "="
        static let emptyCharacterName = ""
        static let defaultValueInt = 0
        static let tokenKeyName = "access_token"
        static let userIDKeyName = "user_id"
        static let tabBarViewControllerID = "tabBarID"
        static let storyboardMainName = "Main"
    }
    // MARK: - Private IBOutlets

    @IBOutlet private weak var vkWKWebView: WKWebView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWKWebView()
    }
    
    // MARK: - Private Methods
    private func loadWKWebView() {
        vkWKWebView.navigationDelegate = self
        guard let url = URL(string: Constants.oAuthURLName)
        else { return }
        let request = URLRequest(url: url)
        vkWKWebView.load(request)
    }
    
    private func presentNextViewController() {
        let storyboard = UIStoryboard(name: Constants.storyboardMainName, bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: Constants.tabBarViewControllerID)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}

// MARK: - WKNavigationDelegate
extension WebViewLoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) ->
                 Void) {
        
        guard
            let url = navigationResponse.response.url,
              url.path == Constants.validPathName,
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: Constants.ampersandCharacterName)
            .map { $0.components(separatedBy: Constants.equalCharacterName) }
            .reduce([String: String]()) { result, parameter in
                var params = result
                let key = parameter.first ?? ""
                let value = parameter.last
                params[key] = value
                return params
            }
        
        let token = params[Constants.tokenKeyName]
        let userID = params[Constants.userIDKeyName]
        Session.shared.token = token ?? Constants.emptyCharacterName
        Session.shared.userID = Int(userID ?? Constants.emptyCharacterName) ?? Constants.defaultValueInt
        decisionHandler(.cancel)
        
        presentNextViewController()
    }
}
