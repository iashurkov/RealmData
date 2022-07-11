//
//  FavoriteScreenInteractor.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  /
//

import Foundation


protocol FavoriteScreenInteractorInput {
}

protocol FavoriteScreenInteractorOutput: AnyObject {
}

final class FavoriteScreenInteractor {
    
    // MARK: Public Properties
    
    weak var presenter: FavoriteScreenInteractorOutput?
    
    // MARK: Init
    
    init() {
    }
}

// MARK: - FavoriteScreenInteractorInput

extension FavoriteScreenInteractor: FavoriteScreenInteractorInput {
}
