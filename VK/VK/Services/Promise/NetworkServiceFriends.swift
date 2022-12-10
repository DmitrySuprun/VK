// NetworkServiceFriends.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import PromiseKit

/// Network service for loading Friends with PromiseKit
struct NetworkServiceFriends {
    // MARK: - Private Constants

    private enum Constants {
        static let scheme = "http"
        static let host = "api.vk.com"
        static let path = "/method/"
        static let accessTokenKeyName = "access_token"
        static let versionKeyName = "v"
        static let versionValueName = "5.131"

        static let friendsGetMethodName = "friends.get"
        static let queryItemFieldsName = "fields"
        static let queryItemValueNickName = "nickname"
        static let queryItemValuePhotoName = "photo_100"
    }

    // MARK: - Public Methods

    func fetchFriends() -> Promise<ResponseFriends> {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        let method = Constants.friendsGetMethodName
        urlComponents.path = Constants.path + method
        let queryItems = [
            URLQueryItem(name: Constants.queryItemFieldsName, value: Constants.queryItemValueNickName),
            URLQueryItem(name: Constants.queryItemFieldsName, value: Constants.queryItemValuePhotoName)
        ]
        urlComponents.queryItems = queryItems
        urlComponents.queryItems?.append(URLQueryItem(
            name: Constants.accessTokenKeyName,
            value: Session.shared.token
        ))
        urlComponents.queryItems?.append(URLQueryItem(
            name: Constants.versionKeyName,
            value: Constants.versionValueName
        ))

        let promise = Promise<ResponseFriends> { resolver in
            AF.request(urlComponents).responseDecodable(of: ResponseFriends.self) { dataResponse in
                switch dataResponse.result {
                case let .success(data):
                    resolver.fulfill(data)
                case let .failure(afError):
                    resolver.reject(afError)
                }
            }
        }
        return promise
    }
}
