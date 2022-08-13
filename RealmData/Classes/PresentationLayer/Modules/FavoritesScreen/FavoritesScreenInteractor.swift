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
    func getPostModels() -> [NewsItemModel]
}

protocol FavoritesScreenInteractorOutput: AnyObject {
}

final class FavoritesScreenInteractor {
    
    // MARK: Public Properties
    
    weak var presenter: FavoritesScreenInteractorOutput?
    
    // MARK: Init
    
    init() {
        
    }
}

// MARK: - FavoritesScreenInteractorInput

extension FavoritesScreenInteractor: FavoritesScreenInteractorInput {
    
    func deletePostModel(_ model: NewsItemModel, completion: (() -> Void)?) {
        
        // MARK: Realm
        
//        RealmStorageManager.shared.delete(model) {
//            completion?()
//        }
        
        // MARK: CoreData
        
        CoreDataManager.shared.delete(model) {
            completion?()
        }
    }
    
    func deletePostModels(completion: (() -> Void)?) {
        
        // MARK: Realm
        
//        RealmStorageManager.shared.deleteAll {
//            completion?()
//        }
        
        // MARK: CoreData
        
        CoreDataManager.shared.deleteAll {
            completion?()
        }
    }
    
    func getPostModels() -> [NewsItemModel] {
        
        // MARK: Realm
        
//        return RealmStorageManager.shared.getAll()
        
        // MARK: CoreData
        
        return CoreDataManager.shared.getAll()
    }
}
