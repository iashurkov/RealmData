//
//  FavoritesScreenInteractor.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//

import Foundation

protocol FavoritesScreenInteractorInput {
    func getAllModesFromRealmStorage() -> [NewsRealmModel]
    func removeModelFromRealmStorage(model: NewsRealmModel, completion: (() -> Void)?)
}

protocol FavoritesScreenInteractorOutput: AnyObject {
}

final class FavoritesScreenInteractor {
    
    // MARK: Public Properties
    
    weak var presenter: FavoritesScreenInteractorOutput?
    
    // MARK: Private Properties
    
    private let realmStorage: RealmStorageManager
    
    // MARK: Init
    
    init(realmStorage: RealmStorageManager) {
        self.realmStorage = realmStorage
    }
}

// MARK: - FavoritesScreenInteractorInput

extension FavoritesScreenInteractor: FavoritesScreenInteractorInput {
    
    func getAllModesFromRealmStorage() -> [NewsRealmModel] {
        return self.realmStorage.getAll()
    }
    
    func removeModelFromRealmStorage(model: NewsRealmModel, completion: (() -> Void)?) {
        self.realmStorage.delete(model: model) {
            completion?()
        }
    }
}
