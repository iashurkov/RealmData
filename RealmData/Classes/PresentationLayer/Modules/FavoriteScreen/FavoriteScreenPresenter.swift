//
//  FavoriteScreenPresenter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//

import Foundation

protocol FavoriteScreenViewOutput: ViewOutput {
}

final class FavoriteScreenPresenter {
    
    // MARK: Public Properties
    
    weak var view: FavoriteScreenViewInput?
    var interactor: FavoriteScreenInteractorInput?
    var router: FavoriteScreenRouterInput?
    
    // MARK: Init
    
    init() {
    }
}

// MARK: - FavoriteScreenViewOutput

extension FavoriteScreenPresenter: FavoriteScreenViewOutput {
}

// MARK: - FavoriteScreenInteractorOutput

extension FavoriteScreenPresenter: FavoriteScreenInteractorOutput {
}
