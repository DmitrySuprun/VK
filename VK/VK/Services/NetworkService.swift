// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Service for loading API data
struct NetworkService {
    // MARK: - Private Constants

    private enum Constants {
        static let scheme = "http"
        static let host = "api.vk.com"
        static let path = "/method/"
        static let accessTokenKeyName = "access_token"
        static let versionKeyName = "v"
        static let versionValueName = "5.131"

        static let groupSearchMethodName = "groups.search"
        static let groupsGetMethodName = "groups.get"
        static let friendsGetMethodName = "friends.get"
        static let getAllPhotosMethodName = "photos.getAll"
        static let newsFeedMethodName = "newsfeed.get"

        static let queryItemSearchName = "q"
        static let queryItemOwnerIDName = "owner_id"
        static let queryItemExtendedName = "extended"
        static let queryItemFieldsName = "fields"
        static let queryItemFilterName = "filter"

        static let queryItemValueNickName = "nickname"
        static let queryItemValuePhotoName = "photo_100"
        static let queryItemValueTrue = "1"
        static let queryItemValueFilerName = "post"
    }

    // MARK: - Public Methods

    func fetchGroupsSearch(searchName: String, completion: @escaping (Result<ResponseGroups, Error>) -> ()) {
        let queryItems = [
            URLQueryItem(name: Constants.queryItemSearchName, value: searchName)
        ]
        fetchData(queryItems: queryItems, method: Constants.groupSearchMethodName, completion: completion)
    }

    func fetchUserGroups(userID: Int, completion: @escaping (Result<ResponseGroups, Error>) -> ()) {
        let queryItems = [
            URLQueryItem(name: Constants.queryItemOwnerIDName, value: String(userID)),
            URLQueryItem(name: Constants.queryItemExtendedName, value: Constants.queryItemValueTrue)
        ]
        fetchData(queryItems: queryItems, method: Constants.groupsGetMethodName, completion: completion)
    }

    func fetchAllUserPhotos(userID: Int, completion: @escaping (Result<ResponseAllPhotos, Error>) -> ()) {
        let queryItems = [
            URLQueryItem(name: Constants.queryItemOwnerIDName, value: String(userID)),
            URLQueryItem(name: Constants.queryItemExtendedName, value: Constants.queryItemValueTrue)
        ]
        fetchData(queryItems: queryItems, method: Constants.getAllPhotosMethodName, completion: completion)
    }

    func fetchFriends(completion: @escaping (Result<ResponseFriends, Error>) -> ()) {
        let queryItems = [
            URLQueryItem(name: Constants.queryItemFieldsName, value: Constants.queryItemValueNickName),
            URLQueryItem(name: Constants.queryItemFieldsName, value: Constants.queryItemValuePhotoName)
        ]
        fetchData(queryItems: queryItems, method: Constants.friendsGetMethodName, completion: completion)
    }

    func fetchNewsFeeds(completion: @escaping (Result<ResponseNewsFeed, Error>) -> ()) {
        let queryItems = [
            URLQueryItem(name: Constants.queryItemFilterName, value: Constants.queryItemValueFilerName),
            URLQueryItem(name: Constants.queryItemOwnerIDName, value: String(Session.shared.userID ?? 0))
        ]
        fetchData(queryItems: queryItems, method: Constants.newsFeedMethodName, completion: completion)
    }

    // MARK: - Private Methods

    private func fetchData<T: Decodable>(
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
            case let .success(data):
                completion(.success(data))
            case let .failure(afError):
                completion(.failure(afError))
            }
        }
    }

    func loadImage(urlName: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        guard let url = URL(string: urlName) else { return }
        AF.request(url).response(completionHandler: { dataResponse in
            switch dataResponse.result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
}
