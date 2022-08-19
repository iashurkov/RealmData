//
//  MigrateStorage.swift
//  RealmData
//
//  Created by iashurkov on 13.08.2022.
//

import Foundation

protocol StorageManagerProtocol {
    func migrate(clearStorageBeforeFilling: Bool, completion: (() -> Void)?)
    func save(_ model: NewsItemModel, completion: (() -> Void)?)
    func update(_ model: NewsItemModel, completion: (() -> Void)?)
    func delete(_ model: NewsItemModel, completion: (() -> Void)?)
    func deleteAll(completion: (() -> Void)?)
    func getModel(with id: Int) -> NewsItemModel?
    func getAll() -> [NewsItemModel]
}

class StorageManager {
    
    static let shared = StorageManager()
    
    private var userDefaultsUseRealmStorage = UserDefaults.standard.bool(forKey: "useRealmStorage")
    private var useRealmStorage = false
    
    func currentStorageManager() -> StorageManagerProtocol {
        if self.useRealmStorage {
            return RealmStorageManager.shared
        }
        
        return CoreDataManager.shared
    }
    
    func checkStorageSystem(with useRealmStorage: Bool, completion: (() -> Void)?) {
        
        self.useRealmStorage = useRealmStorage
        
        if self.userDefaultsUseRealmStorage != self.useRealmStorage {
            UserDefaults.standard.set(self.useRealmStorage, forKey: "useRealmStorage")
            
            self.currentStorageManager().migrate(clearStorageBeforeFilling: true) {
                completion?()
            }
        } else {
            completion?()
        }
    }
}
