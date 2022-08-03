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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.updateNewsList),
                                               name: .updateNewsList,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Private methods
    
    @objc private func updateNewsList(_ notification: Notification) {
        self.checkStorageModel {
            if let models = self.newsModels {
                self.view?.didOdtainData(with: models)
            }
        }
    }
    
    private func checkStorageModel(completion: (() -> Void)?) {
        let realmModels = self.realmStorage.getAll()
        
        for item in realmModels {
            if let index = self.newsModels?.result.firstIndex(where: { $0.id == item.id }) {
                self.newsModels?.result[index].isFavorite = item.isFavorite
            }
        }
        
        completion?()
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
                self.checkStorageModel {
                    if let models = self.newsModels {
                        self.view?.didOdtainData(with: models)
                    }
                }
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
        if isFavorite {
            self.realmStorage.save(model: newsModel, completion: {
                NotificationCenter.default.post(Notification(name: .updateFavoriteList))
            })
        } else {
            self.realmStorage.delete(model: newsModel, completion: {
                NotificationCenter.default.post(Notification(name: .updateFavoriteList))
            })
        }
    }
}

// MARK: - NewsScreenInteractorOutput

extension NewsScreenPresenter: NewsScreenInteractorOutput {
}
