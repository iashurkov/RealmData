//
//  FavoritesScreenPresenter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
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
    
    private var newsModels: [NewsRealmModel]?
    private let realmStorage: RealmStorageManager = RealmStorageManagerImp()
    
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
        // TODO: update view screen
        
        let models = self.realmStorage.getAll()
        self.newsModels = models
        
        print("[ ## ] DEBUG : updateFavoriteList : model = \(String(describing: self.newsModels))")
        
        self.view?.didOdtainData(with: self.newsModels)
    }
}

// MARK: - FavoritesScreenViewOutput

extension FavoritesScreenPresenter: FavoritesScreenViewOutput {
    
    func didTapFavoriteButton(for id: Int?, isFavorite: Bool) {
//        guard
//            self.newsModel?.isEmpty == false,
//            let id = id,
//            let model = self.newsModel?.first(where: { $0.id == id })
//        else { return }
        
    }
}

// MARK: - FavoritesScreenInteractorOutput

extension FavoritesScreenPresenter: FavoritesScreenInteractorOutput {
}
