//
//  NewsScreenInteractor.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  /
//

import Foundation


protocol NewsScreenInteractorInput {
}

protocol NewsScreenInteractorOutput: AnyObject {
}

final class NewsScreenInteractor {
    
    // MARK: Public Properties
    
    weak var presenter: NewsScreenInteractorOutput?
    
    // MARK: Init
    
    init() {
    }
}

// MARK: - NewsScreenInteractorInput

extension NewsScreenInteractor: NewsScreenInteractorInput {
}
