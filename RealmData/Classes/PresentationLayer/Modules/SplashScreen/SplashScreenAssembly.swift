//
//  SplashScreenAssembly.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  /
//

import UIKit

final class SplashScreenAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> UIViewController {
        guard let model = model as? SceneDelegateInput else { fatalError() }
        
        let view = SplashScreenViewController()
        let router = SplashScreenRouter(appDelegate: model,
                                        view: view)
        let presenter = SplashScreenPresenter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        
        router.view = view
        
        return view
    }
}

// MARK: - Transition model

extension SplashScreenAssembly {
    
    struct Model: TransitionModel {
    }
}
