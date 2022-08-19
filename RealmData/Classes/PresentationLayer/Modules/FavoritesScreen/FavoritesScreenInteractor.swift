//
//  FavoritesScreenInteractor.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//

import Foundation

protocol FavoritesScreenInteractorInput {
    func deletePostModel(_ model: NewsItemModel, completion: (() -> Void)?)
    func deletePostModels(completion: (() -> Void)?)
    func getPostModels() -> [NewsItemModel]?
}

protocol FavoritesScreenInteractorOutput: AnyObject {
}

final class FavoritesScreenInteractor {
    
    // MARK: Public Properties
    
    weak var presenter: FavoritesScreenInteractorOutput?
    
    // MARK: Private Properties
    
    private let currentStorageManager: StorageManagerProtocol?
    
    // MARK: Init
    
    init() {
        self.currentStorageManager = StorageManager.shared.currentStorageManager()
    }
}

// MARK: - FavoritesScreenInteractorInput

extension FavoritesScreenInteractor: FavoritesScreenInteractorInput {
    
    func deletePostModel(_ model: NewsItemModel, completion: (() -> Void)?) {
        self.currentStorageManager?.delete(model) {
            completion?()
        }
    }
    
    func deletePostModels(completion: (() -> Void)?) {
        self.currentStorageManager?.deleteAll {
            completion?()
        }
    }
    
    func getPostModels() -> [NewsItemModel]? {
        return self.currentStorageManager?.getAll()
    }
}
