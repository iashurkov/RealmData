//
//  FavoritesScreenInteractor.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  /
//

import Foundation


protocol FavoritesScreenInteractorInput {
}

protocol FavoritesScreenInteractorOutput: AnyObject {
}

final class FavoritesScreenInteractor {
    
    // MARK: Public Properties
    
    weak var presenter: FavoritesScreenInteractorOutput?
    
    // MARK: Init
    
    init() {
    }
}

// MARK: - FavoritesScreenInteractorInput

extension FavoritesScreenInteractor: FavoritesScreenInteractorInput {
}
