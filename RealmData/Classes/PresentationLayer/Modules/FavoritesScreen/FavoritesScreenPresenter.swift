//
//  FavoritesScreenPresenter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//

import Foundation

protocol FavoritesScreenViewOutput: ViewOutput {
}

final class FavoritesScreenPresenter {
    
    // MARK: Public Properties
    
    weak var view: FavoritesScreenViewInput?
    var interactor: FavoritesScreenInteractorInput?
    var router: FavoritesScreenRouterInput?
    
    // MARK: Init
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.updateDatabase),
                                               name: .updateDatabase,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Private methods
    
    @objc private func updateDatabase(_ notification: Notification) {
        // TODO: update view screen
    }
}

// MARK: - FavoritesScreenViewOutput

extension FavoritesScreenPresenter: FavoritesScreenViewOutput {
}

// MARK: - FavoritesScreenInteractorOutput

extension FavoritesScreenPresenter: FavoritesScreenInteractorOutput {
}
