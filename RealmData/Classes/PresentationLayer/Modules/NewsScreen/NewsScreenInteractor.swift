//
//  NewsScreenInteractor.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//

import Foundation

protocol NewsScreenInteractorInput {
    func obtainData() -> NewsModels
    
    func savePostModel(_ model: NewsItemModel, completion: (() -> Void)?)
    func deletePostModel(_ model: NewsItemModel, completion: (() -> Void)?)
    func deletePostModels(completion: (() -> Void)?)
    func getPostModels() -> [NewsItemModel]
}

protocol NewsScreenInteractorOutput: AnyObject {
}

final class NewsScreenInteractor {
    
    // MARK: Public Properties
    
    weak var presenter: NewsScreenInteractorOutput?
    
    // MARK: Init
    
    init() {
        
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
    
    func savePostModel(_ model: NewsItemModel, completion: (() -> Void)?) {
        
        // MARK: Realm
        
//        RealmStorageManager.shared.save(model: model) {
//            completion?()
//        }
        
        // MARK: CoreData
        
        CoreDataManager.shared.save(model) {
            completion?()
        }
    }
    
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
