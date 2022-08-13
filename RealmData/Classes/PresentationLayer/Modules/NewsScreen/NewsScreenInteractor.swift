//
//  NewsScreenInteractor.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//

import Foundation

protocol NewsScreenInteractorInput {
    func obtainData() -> NewsModels
    
    func getAllModesFromRealmStorage() -> [NewsRealmModel]
    func addModelToRealmStorage(model: NewsRealmModel, completion: (() -> Void)?)
    func removeModelFromRealmStorage(model: NewsRealmModel, completion: (() -> Void)?)
    
    func getAllModesFromCoreData() -> [NewsItemModel]
}

protocol NewsScreenInteractorOutput: AnyObject {
}

final class NewsScreenInteractor {
    
    // MARK: Public Properties
    
    weak var presenter: NewsScreenInteractorOutput?
    
    // MARK: Private Properties
    
    private let realmStorage: RealmStorageManager
    
    // MARK: Init
    
    init(realmStorage: RealmStorageManager) {
        self.realmStorage = realmStorage
    }
}

// MARK: - NewsScreenInteractorInput

extension NewsScreenInteractor: NewsScreenInteractorInput {
    
    func obtainData() -> NewsModels {
        if let url = Bundle.main.url(forResource: "NewsMockData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NewsModels.self, from: data)
                
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        
        return NewsModels(result: [])
    }
    
    func getAllModesFromRealmStorage() -> [NewsRealmModel] {
        return self.realmStorage.getAll()
    }
    
    func addModelToRealmStorage(model: NewsRealmModel, completion: (() -> Void)?) {
        self.realmStorage.save(model: model) {
            completion?()
        }
    }
    
    func removeModelFromRealmStorage(model: NewsRealmModel, completion: (() -> Void)?) {
        self.realmStorage.delete(model: model) {
            completion?()
        }
    }
    
    func getAllModesFromCoreData() -> [NewsItemModel] {
        return CoreDataManager.shared.getAll()
    }
}
