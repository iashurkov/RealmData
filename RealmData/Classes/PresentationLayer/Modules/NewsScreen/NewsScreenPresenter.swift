//
//  NewsScreenPresenter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//

import Foundation
import RealmSwift

protocol NewsScreenViewOutput: ViewOutput {
    func didTapFavoriteButton(for id: Int?, isFavorite: Bool)
}

final class NewsScreenPresenter {
    
    // MARK: Public Properties
    
    weak var view: NewsScreenViewInput?
    var interactor: NewsScreenInteractorInput?
    var router: NewsScreenRouterInput?
    
    // MARK: Private Properties
    
    private var newsModels: NewsModels?
    private let realmStorage: RealmStorageManager = RealmStorageManagerImp()
    
    // MARK: Init
    
    init() {
    }
}

// MARK: - NewsScreenViewOutput

extension NewsScreenPresenter: NewsScreenViewOutput {
    
    func viewDidLoad() {
        if let url = Bundle.main.url(forResource: "NewsMockData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NewsModels.self, from: data)
                
                self.newsModels = jsonData
                self.view?.didOdtainData(with: jsonData)
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    func didTapFavoriteButton(for id: Int?, isFavorite: Bool) {
        guard
            self.newsModels?.result.isEmpty == false,
            let id = id,
            let model = self.newsModels?.result.first(where: { $0.id == id })
        else { return }
        
        let newsModel = NewsRealmModel(id: model.id,
                                       title: model.title,
                                       descriptionNews: model.description,
                                       date: model.date,
                                       isFavorite: isFavorite)
        
        // TODO: add/delete model to/from Realm
        
        if isFavorite {
            print("[ ## ] Add model to Realm storage")
            self.realmStorage.save(model: newsModel, completion: {
                NotificationCenter.default.post(Notification(name: .updateDatabase))
            })
        } else {
            print("[ ## ] Delete model from Realm storage")
            self.realmStorage.delete(model: newsModel, completion: {
                NotificationCenter.default.post(Notification(name: .updateDatabase))
            })
        }
    }
}

// MARK: - NewsScreenInteractorOutput

extension NewsScreenPresenter: NewsScreenInteractorOutput {
}
