// DatabaseService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Realm Database service
struct DatabaseService {
    // MARK: - Public Methods

    func saveData<T: Object>(objects: [T]) {
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

    func loadData<T: Object>(objectType: T.Type) -> [T]? {
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
}
