//
//  FavoritesScreenRouter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//


protocol FavoritesScreenRouterInput {
}

final class FavoritesScreenRouter {
    
    // MARK: Public Properties
    
    weak var view: ModuleTransitionHandler?
}

// MARK: FavoritesScreenRouterInput

extension FavoritesScreenRouter: FavoritesScreenRouterInput {
}
