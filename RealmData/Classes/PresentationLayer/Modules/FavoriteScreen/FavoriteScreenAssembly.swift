//
//  FavoriteScreenAssembly.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  /
//

import UIKit

final class FavoriteScreenAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> UIViewController {
        guard model is Model
            else { fatalError() }
        
        let view = FavoriteScreenViewController()
        let router = FavoriteScreenRouter()
        let presenter = FavoriteScreenPresenter()
        let interactor = FavoriteScreenInteractor()
        
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

extension FavoriteScreenAssembly {
    
    struct Model: TransitionModel {
    }
}
