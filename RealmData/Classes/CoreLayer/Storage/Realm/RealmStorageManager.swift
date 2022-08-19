//
//  RealmStorageManager.swift
//  RealmData
//
//  Created by iashurkov on 29.07.2022.
//

import Foundation
import RealmSwift

class RealmStorageManager: StorageManagerProtocol {
    
    static let shared = RealmStorageManager()
    
    private lazy var realmStorage = try? Realm()
    
    // CoreData -> Realm
    func migrate(clearStorageBeforeFilling: Bool, completion: (() -> Void)?) {
        let coreDataModels = CoreDataManager.shared.getAll()
        
        let completionAfterClear = {
            for model in coreDataModels {
                let realmModel = NewsRealmModel(id: model.id,
                                                title: model.title,
                                                descriptionNews: model.description,
                                                date: model.date,
                                                isFavorite: model.isFavorite ?? false)
                
                try? self.realmStorage?.safeWrite {
                    self.realmStorage?.add(realmModel)
                }
            }
            
            CoreDataManager.shared.deleteAll {
                completion?()
            }
        }
        
        if clearStorageBeforeFilling {
            self.deleteAll {
                completionAfterClear()
            }
        } else {
            completionAfterClear()
        }
    }
    
    func save(_ model: NewsItemModel, completion: (() -> Void)?) {
        let realmModel = NewsRealmModel(id: model.id,
                                        title: model.title,
                                        descriptionNews: model.description,
                                        date: model.date,
                                        isFavorite: model.isFavorite ?? false)
        
        try? self.realmStorage?.safeWrite {
            self.realmStorage?.add(realmModel)
            completion?()
        }
    }
    
    func update(_ model: NewsItemModel, completion: (() -> Void)?) {
        let realmModel = NewsRealmModel(id: model.id,
                                        title: model.title,
                                        descriptionNews: model.description,
                                        date: model.date,
                                        isFavorite: model.isFavorite ?? false)
        
        try? self.realmStorage?.safeWrite {
            self.realmStorage?.add(realmModel, update: .modified)
            completion?()
        }
    }
    
    func delete(_ model: NewsItemModel, completion: (() -> Void)?) {
        let idPredicate = NSPredicate(format: "id == %ld", model.id)
        
        if let model = self.realmStorage?.objects(NewsRealmModel.self).filter(idPredicate) {
            try? self.realmStorage?.safeWrite {
                self.realmStorage?.delete(model)
                completion?()
            }
        }
    }
    
    func deleteAll(completion: (() -> Void)?) {
        if let models = self.realmStorage?.objects(NewsRealmModel.self) {
            try? self.realmStorage?.safeWrite {
                self.realmStorage?.delete(models)
                completion?()
            }
        }
    }
    
    func getModel(with id: Int) -> NewsItemModel? {
        let idPredicate = NSPredicate(format: "id == %ld", id)
        
        if let objects = self.realmStorage?.objects(NewsRealmModel.self).filter(idPredicate),
           let model = objects.first {
            return NewsItemModel(id: model.id,
                                 title: model.title,
                                 description: model.descriptionNews,
                                 date: model.date,
                                 isFavorite: model.isFavorite)
        }
        
        return nil
    }
    
    func getAll() -> [NewsItemModel] {
        let models = self.realmStorage?.objects(NewsRealmModel.self)
        var newsModels: [NewsItemModel] = []
        
        models?.forEach({
            let item = NewsItemModel(id: $0.id,
                                     title: $0.title,
                                     description: $0.descriptionNews,
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
