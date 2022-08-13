//
//  FavoritesScreenPresenter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  

import Foundation
import RealmSwift

protocol FavoritesScreenViewOutput: ViewOutput {
    func didTapFavoriteButton(for id: Int?, isFavorite: Bool)
}

final class FavoritesScreenPresenter {
    
    // MARK: Public Properties
    
    weak var view: FavoritesScreenViewInput?
    var interactor: FavoritesScreenInteractorInput?
    var router: FavoritesScreenRouterInput?
    
    // MARK: Private Properties
    
    private var newsModels: [NewsItemModel]?
    
    // MARK: Init
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.updateFavoriteList),
                                               name: .updateFavoriteList,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Private methods
    
    @objc private func updateFavoriteList(_ notification: Notification) {
        self.obtainData()
    }
    
    private func obtainData() {
//        self.newsModels = self.interactor?.getAllModesFromRealmStorage()
        self.newsModels = self.interactor?.getAllModesFromCoreData()
        
        self.view?.didOdtainData(with: self.newsModels)
    }
}

// MARK: - FavoritesScreenViewOutput

extension FavoritesScreenPresenter: FavoritesScreenViewOutput {
    
    func viewDidLoad() {
        self.obtainData()
    }
    
    func didTapFavoriteButton(for id: Int?, isFavorite: Bool) {
        guard
            self.newsModels?.isEmpty == false,
            let id = id,
            let model = self.newsModels?.first(where: { $0.id == id })
        else { return }
        
//        let newsModel = NewsRealmModel(id: model.id,
//                                       title: model.title,
//                                       descriptionNews: model.description,
//                                       date: model.date,
//                                       isFavorite: isFavorite)
//
//        self.interactor?.removeModelFromRealmStorage(model: newsModel) {
//            if let index = self.newsModels?.firstIndex(where: { $0.id == id }) {
//                self.newsModels?.remove(at: index)
//                self.view?.didOdtainData(with: self.newsModels)
//            }
//
//            NotificationCenter.default.post(Notification(name: .updateNewsList))
//        }
        
        let newsModel = NewsItemModel(id: model.id,
                                      title: model.title,
                                      description: model.description,
                                      date: model.date,
                                      isFavorite: isFavorite)
        
        self.interactor?.removeModelFromCoreData(model: newsModel) {
            if let index = self.newsModels?.firstIndex(where: { $0.id == id }) {
                self.newsModels?.remove(at: index)
                self.view?.didOdtainData(with: self.newsModels)
            }
            
            NotificationCenter.default.post(Notification(name: .updateNewsList))
        }
    }
}

// MARK: - FavoritesScreenInteractorOutput

extension FavoritesScreenPresenter: FavoritesScreenInteractorOutput {
}
