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
    func removeAllItems()
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
        self.newsModels = self.interactor?.getPostModels()
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
        
        self.interactor?.deletePostModel(model) {
            if let index = self.newsModels?.firstIndex(where: { $0.id == id }) {
                self.newsModels?.remove(at: index)
                self.view?.didOdtainData(with: self.newsModels)
            }
            
            NotificationCenter.default.post(name: .unselectPost, object: nil, userInfo: ["id" : id])
        }
    }
    
    func removeAllItems() {
        self.interactor?.deletePostModels() {
            self.obtainData()
            NotificationCenter.default.post(Notification(name: .unselectAllPosts))
        }
    }
}

// MARK: - FavoritesScreenInteractorOutput

extension FavoritesScreenPresenter: FavoritesScreenInteractorOutput {
}
