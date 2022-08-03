//
//  NewsScreenAssembly.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
// 

import UIKit

final class NewsScreenAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> UIViewController {
        guard model is Model
        else { fatalError() }
        
        let realmStorage: RealmStorageManager = RealmStorageManagerImp()
        
        let view = NewsScreenViewController()
        let router = NewsScreenRouter()
        let presenter = NewsScreenPresenter()
        let interactor = NewsScreenInteractor(realmStorage: realmStorage)
        
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

extension NewsScreenAssembly {
    
    struct Model: TransitionModel {
    }
}
