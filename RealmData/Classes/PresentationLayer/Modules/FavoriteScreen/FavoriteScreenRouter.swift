//
//  FavoriteScreenRouter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//


protocol FavoriteScreenRouterInput {
}

final class FavoriteScreenRouter {
    
    // MARK: Public Properties
    
    weak var view: ModuleTransitionHandler?
}

// MARK: FavoriteScreenRouterInput

extension FavoriteScreenRouter: FavoriteScreenRouterInput {
}
