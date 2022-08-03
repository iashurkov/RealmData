//
//  FavoritesScreenAssembly.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//

import UIKit

final class FavoritesScreenAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> UIViewController {
        guard model is Model
        else { fatalError() }
        
        let realmStorage: RealmStorageManager = RealmStorageManagerImp()
        
        let view = FavoritesScreenViewController()
        let router = FavoritesScreenRouter()
        let presenter = FavoritesScreenPresenter()
        let interactor = FavoritesScreenInteractor(realmStorage: realmStorage)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}

// MARK: - Transition model

extension FavoritesScreenAssembly {
    
    struct Model: TransitionModel {
    }
}
