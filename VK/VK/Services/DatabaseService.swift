// DatabaseService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Realm Database service
struct DatabaseService {
    // MARK: - Private Properties

    private var notificationToken = NotificationToken()

    // MARK: - Public Methods

    func save<T: Object>(objects: [T]) {
        do {
            // MARK: - TODO Remove migration config

            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: false)
            let realm = try Realm(configuration: configuration)

            try realm.write {
                objects.forEach { realm.add($0, update: .modified) }
            }
        } catch {
            print(#function, error)
        }
    }

    func load<T: Object>(objectType: T.Type) -> [T]? {
        do {
            let realm = try Realm()
            print("❌", realm.configuration.fileURL)
            let objects = Array(realm.objects(objectType))
            return objects
        } catch {
            print(#function, error)
            return nil
        }
    }

    mutating func setupNotification<T: Object>(
        objectType: T.Type,
        completion: @escaping (RealmCollectionChange<Results<T>>) -> ()
    ) {
        do {
            let realm = try Realm()
            let objects = realm.objects(objectType)
            notificationToken = objects.observe(completion)
        } catch {
            print(#function, error)
        }
    }

    func delete<T: Object>(object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(#function, error)
        }
    }
}
