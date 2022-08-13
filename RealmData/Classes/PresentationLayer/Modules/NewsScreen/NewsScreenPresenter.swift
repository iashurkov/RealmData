//
//  NewsScreenPresenter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
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
        if let coreDataModels = self.interactor?.getPostModels() {
            for item in coreDataModels {
                if let index = self.newsModels?.result.firstIndex(where: { $0.id == item.id }) {
                    self.newsModels?.result[index].isFavorite = item.isFavorite
                }
            }
        }
        
        completion?()
    }
}

// MARK: - NewsScreenViewOutput

extension NewsScreenPresenter: NewsScreenViewOutput {
    
    func viewDidLoad() {
        self.newsModels = self.interactor?.obtainData()
        self.checkStorageModel {
            if let models = self.newsModels {
                self.view?.didOdtainData(with: models)
            }
        }
    }
    
    func didTapFavoriteButton(for id: Int?, isFavorite: Bool) {
        guard
            self.newsModels?.result.isEmpty == false,
            let id = id,
            var model = self.newsModels?.result.first(where: { $0.id == id })
        else { return }
        
        if isFavorite {
            model.isFavorite = true
            
            self.interactor?.savePostModel(model) {
                NotificationCenter.default.post(Notification(name: .updateFavoriteList))
            }
        } else {
            self.interactor?.deletePostModel(model) {
                NotificationCenter.default.post(Notification(name: .updateFavoriteList))
            }
        }
    }
}

// MARK: - NewsScreenInteractorOutput

extension NewsScreenPresenter: NewsScreenInteractorOutput {
}
