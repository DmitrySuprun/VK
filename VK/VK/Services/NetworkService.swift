// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Service for loading API data
final class NetworkService {
    // MARK: - Private Constants

    private struct Constants {
        static let scheme = "http"
        static let host = "api.vk.com"
        static let path = "/method/"
        static let accessTokenKeyName = "access_token"
        static let versionKeyName = "v"
        static let versionValueName = "5.131"
    }

    // MARK: - Public Methods

    func fetchUserGroups(userID: Int, completion: @escaping (Result<Groups, Error>) -> ()) {
        let queryItems = [
            URLQueryItem(name: "owner_id", value: String(userID)),
            URLQueryItem(name: "extended", value: "1")
        ]
        fetchData(queryItems: queryItems, method: "groups.get", completion: completion)
    }

    func fetchAllUserPhotos(userID: Int, completion: @escaping (Result<Photos, Error>) -> ()) {
        let queryItems = [
            URLQueryItem(name: "owner_id", value: String(userID)),
            URLQueryItem(name: "extended", value: "1")
        ]
        fetchData(queryItems: queryItems, method: "photos.getAll", completion: completion)
    }

    func fetchFriends(completion: @escaping (Result<Friends, Error>) -> ()) {
        let queryItems = [
            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "fields", value: "photo_100")
        ]
        fetchData(queryItems: queryItems, method: "friends.get", completion: completion)
    }

    func fetchData<T: Decodable>(
        queryItems: [URLQueryItem],
        method: String,
        completion: @escaping (Result<T, Error>) -> ()
    ) {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.path + method
        urlComponents.queryItems = queryItems
        urlComponents.queryItems?.append(URLQueryItem(
            name: Constants.accessTokenKeyName,
            value: Session.shared.token
        ))
        urlComponents.queryItems?.append(URLQueryItem(
            name: Constants.versionKeyName,
            value: Constants.versionValueName
        ))

        AF.request(urlComponents).responseDecodable(of: T.self) { dataResponse in
            switch dataResponse.result {
            case let .success(data): completion(.success(data))
            case let .failure(afError): completion(.failure(afError))
            }
        }
    }
}
