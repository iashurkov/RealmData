//
//  NewsScreenRouter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//


protocol NewsScreenRouterInput {
}

final class NewsScreenRouter {
    
    // MARK: Public Properties
    
    weak var view: ModuleTransitionHandler?
}

// MARK: - NewsScreenRouterInput

extension NewsScreenRouter: NewsScreenRouterInput {
}
