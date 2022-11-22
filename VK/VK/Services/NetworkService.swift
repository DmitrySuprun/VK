//
//  NetworkService.swift
//  VK
//
//  Created by Дмитрий Супрун on 22.11.22.
//

import Foundation

/// Service  for loading API data
final class NetworkService {
    // MARK: - Private Constants
    private enum Constants {
        static let scheme = "http"
        static let host = "api.vk.com"
        static let path = "/method/"
        static let accessTokenKeyName = "access_token"
        static let versionKeyName = "v"
        static let versionValueName = "5.131"
    }
    
    // MARK: - Private Properties
    private var urlComponents = URLComponents()
    
    // MARK: - Public Methods
    func fetchData(method: String, queryItems: [URLQueryItem]) {
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.path + method
        urlComponents.queryItems = queryItems
        urlComponents.queryItems?.append(URLQueryItem(name: Constants.accessTokenKeyName,
                                                      value: Session.shared.token))
        urlComponents.queryItems?.append(URLQueryItem(name: Constants.versionKeyName,
                                                      value: Constants.versionValueName))

        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data)
            print(json)
            print(response)
            print(error)
        }
        task.resume()
    }
}
