//
//  SplashScreenRouter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  

import UIKit

protocol SplashScreenRouterInput {
    func setStartScreen()
}

final class SplashScreenRouter {
    
    // MARK: Private properties
    
    weak var appDelegate: SceneDelegateInput?
    weak var view: ModuleTransitionHandler?
    
    // MARK: init
    
    init(appDelegate: SceneDelegateInput,
         view: ModuleTransitionHandler) {
        self.appDelegate = appDelegate
        self.view = view
    }
}

// MARK: - SplashScreenRouterInput

extension SplashScreenRouter: SplashScreenRouterInput {
    
    func setStartScreen() {
        self.appDelegate?.setStartScreen()
    }
}
