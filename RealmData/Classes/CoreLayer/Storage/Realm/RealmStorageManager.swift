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
    func deleteAll(completion: (() -> Void)?)
    func getAll() -> [NewsRealmModel]
}

class RealmStorageManagerImp: RealmStorageManager {
    
    // TODO: Add singleton : let shared = RealmStorageManager()
    
    private lazy var realmStorage = try? Realm()
    
    func save(model: NewsRealmModel, completion: (() -> Void)?) {
        try? self.realmStorage?.write {
            self.realmStorage?.add(model)
            completion?()
        }
    }
    
    func update(model: NewsRealmModel, completion: (() -> Void)?) {
        try? self.realmStorage?.write {
            self.realmStorage?.add(model, update: .modified)
            completion?()
        }
    }
    
    func delete(model: NewsRealmModel, completion: (() -> Void)?) {
        let idPredicate = NSPredicate(format: "id == %ld", model.id)
        
        if let model = self.realmStorage?.objects(NewsRealmModel.self).filter(idPredicate) {
            try? self.realmStorage?.write {
                self.realmStorage?.delete(model)
                completion?()
            }
        }
    }
    
    func deleteAll(completion: (() -> Void)?) {
        if let models = self.realmStorage?.objects(NewsRealmModel.self) {
            try? self.realmStorage?.write {
                self.realmStorage?.delete(models)
                completion?()
            }
        }
    }
    
    func getAll() -> [NewsRealmModel] {
        let models = self.realmStorage?.objects(NewsRealmModel.self)
        var newsModels: [NewsRealmModel] = []
        
        models?.forEach({
            let item = NewsRealmModel(id: $0.id,
                                      title: $0.title,
                                      descriptionNews: $0.descriptionNews,
                                      date: $0.date,
                                      isFavorite: $0.isFavorite)
            newsModels.append(item)
        })
        
        newsModels.sort {
            $0.id < $1.id
        }
        
        return newsModels
    }
}
