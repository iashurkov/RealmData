//
//  RealmStorageManager.swift
//  RealmData
//
//  Created by iashurkov on 29.07.2022.
//

import Foundation
import RealmSwift

protocol RealmStorageManager {
    func save(model: NewsRealmModel, completion: (() -> Void)?)
    func update(model: NewsRealmModel, completion: (() -> Void)?)
    func delete(model: NewsRealmModel, completion: (() -> Void)?)
    func deleteAll()
    func getAll() -> [NewsRealmModel]
}

class RealmStorageManagerImp: RealmStorageManager {
    
    private lazy var realmStorage = try? Realm()
    
    func save(model: NewsRealmModel, completion: (() -> Void)?) {
        try? self.realmStorage?.write {
            print("[ ## ] DEBUG : Add new model in realm storage")
            self.realmStorage?.add(model)
            completion?()
        }
    }
    
    func update(model: NewsRealmModel, completion: (() -> Void)?) {
        try? self.realmStorage?.write {
            print("[ ## ] DEBUG : Update model in realm storage")
            self.realmStorage?.add(model, update: .modified)
            completion?()
        }
    }
    
    func delete(model: NewsRealmModel, completion: (() -> Void)?) {
        try? self.realmStorage?.write {
            print("[ ## ] DEBUG : Delete model from realm storage")
            self.realmStorage?.delete(model)
            completion?()
        }
    }
    
    func deleteAll() {
        if let models = self.realmStorage?.objects(NewsRealmModel.self) {
            try? self.realmStorage?.write {
                print("[ ## ] DEBUG : Delete all models from realm storage")
                self.realmStorage?.delete(models)
            }
        }
    }
    
    func getAll() -> [NewsRealmModel] {
        let models = self.realmStorage?.objects(NewsRealmModel.self)
        var newsModels: [NewsRealmModel] = []
        
        print("[ ## ] DEBUG : Get all \(String(describing: models?.count)) models from realm storage")
        
        models?.forEach({
            let item = NewsRealmModel(id: $0.id,
                                      title: $0.title,
                                      descriptionNews: $0.descriptionNews,
                                      date: $0.date,
                                      isFavorite: $0.isFavorite)
            newsModels.append(item)
        })
        
        return newsModels
    }
}
