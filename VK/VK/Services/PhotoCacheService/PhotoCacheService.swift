// PhotoCacheService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import UIKit

/// Fetch Images and Caching Images
final class PhotoCacheService {
    // MARK: - Private Constants

    private enum Constants {
        static let imagePathName = "images"
        static let slashName = "/"
        static let defaultName: String.SubSequence = "default"
    }

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private let cacheLifeTime: TimeInterval = 24 * 60 * 60
    private var images = [String: UIImage]()

    // MARK: - Public Methods

    func photo(byUrl url: String, completion: @escaping (UIImage?) -> Void) {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
            completion(image)
        } else if let photo = getImageFromCache(url: url) {
            image = photo
            completion(image)
        } else {
            loadPhoto(byUrl: url, completion: completion)
        }
    }

    // MARK: - Private Methods

    private static let pathName: String = {
        let pathName = Constants.imagePathName
        guard let cachesDirectory = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first
        else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()

    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first
        else { return nil }
        let hashName = url.split(separator: Constants.slashName).last ?? Constants.defaultName
        return cachesDirectory.appendingPathComponent(PhotoCacheService.pathName + Constants.slashName + hashName).path
    }

    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData()
        else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }

    private func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName)
        else { return nil }
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }

    private func loadPhoto(byUrl url: String, completion: @escaping (UIImage?) -> Void) {
        networkService.loadImage(urlName: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                guard let data,
                      let image = UIImage(data: data)
                else { return }
                self.images[url] = image
                self.saveImageToCache(url: url, image: image)
                completion(image)
            case let .failure(error):
                completion(nil)
                print(error.localizedDescription)
            }
        }
    }
}
