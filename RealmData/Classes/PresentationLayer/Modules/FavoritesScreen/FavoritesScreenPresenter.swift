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
    }
}

// MARK: - FavoritesScreenViewOutput

extension FavoritesScreenPresenter: FavoritesScreenViewOutput {
}

// MARK: - FavoritesScreenInteractorOutput

extension FavoritesScreenPresenter: FavoritesScreenInteractorOutput {
}
