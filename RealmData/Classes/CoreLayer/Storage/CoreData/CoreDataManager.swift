//
//  CoreDataManager.swift
//  RealmData
//
//  Created by iashurkov on 10.08.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModels")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("[ ## ] FatalError : Unable to init CoreData : \(error)")
            }
        }
        
        return container
    }()
    
    private func updateStorage(_ completion: (() -> Void)?) {
        let context = self.persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                completion?()
            } catch {
                let nsError = error as NSError
                fatalError("[ ## ] FatalError : Unresolved CoreData error : \(nsError)")
            }
        }
    }
    
    func save(_ model: NewsItemModel, completion: (() -> Void)?) {
        let coreDataModel = News(context: self.persistentContainer.viewContext)
        coreDataModel.id = Int16(model.id)
        coreDataModel.title = model.title
        coreDataModel.descriptionNews = model.description
        coreDataModel.date = model.date
        coreDataModel.isFavorite = model.isFavorite ?? false
        
        self.updateStorage(completion)
    }
    
    func delete(_ model: NewsItemModel, completion: (() -> Void)?) {
        let context = self.persistentContainer.viewContext
        let request: NSFetchRequest<News> = News.fetchRequest()
        request.predicate = NSPredicate(format: "id == %ld", model.id)
        
        if let models = try? context.fetch(request) {
            for object in models {
                context.delete(object)
            }
        }
        
        self.updateStorage(completion)
    }
    
    func deleteAll(completion: (() -> Void)?) {
        let context = self.persistentContainer.viewContext
        let request: NSFetchRequest<News> = News.fetchRequest()
        
        if let models = try? context.fetch(request) {
            for object in models {
                context.delete(object)
            }
        }
        
        self.updateStorage(completion)
    }
    
    func getModel(with id: Int) -> NewsItemModel? {
        let context = self.persistentContainer.viewContext
        let request: NSFetchRequest<News> = News.fetchRequest()
        request.predicate = NSPredicate(format: "id == %ld", id)
        
        if let models = try? context.fetch(request),
           let item = models.first {
            let model = NewsItemModel(id: Int(item.id),
                                     title: item.title,
                                     description: item.descriptionNews,
                                     date: item.date,
                                     isFavorite: item.isFavorite)
            return model
        }
        
        return nil
    }
    
    func getAll() -> [NewsItemModel] {
        let request: NSFetchRequest<News> = News.fetchRequest()
        var fetchModels: [News] = []
        var newsModels: [NewsItemModel] = []
        
        do {
            fetchModels = try self.persistentContainer.viewContext.fetch(request)
            
            fetchModels.forEach({
                let item = NewsItemModel(id: Int($0.id),
                                         title: $0.title,
                                         description: $0.descriptionNews,
                                         date: $0.date,
                                         isFavorite: $0.isFavorite)
                newsModels.append(item)
            })
        } catch {
            let nsError = error as NSError
            fatalError("[ ## ] FatalError : Error fetching objects : \(nsError)")
        }
        
        newsModels.sort {
            $0.id < $1.id
        }
        
        return newsModels
    }
}
