//
//  NewsScreenPresenter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//

import Foundation

protocol NewsScreenViewOutput: ViewOutput {
}

final class NewsScreenPresenter {
    
    // MARK: Public Properties
    
    weak var view: NewsScreenViewInput?
    var interactor: NewsScreenInteractorInput?
    var router: NewsScreenRouterInput?
    
    // MARK: Init
    
    init() {
    }
}

// MARK: - NewsScreenViewOutput

extension NewsScreenPresenter: NewsScreenViewOutput {
}

// MARK: - NewsScreenInteractorOutput

extension NewsScreenPresenter: NewsScreenInteractorOutput {
}
