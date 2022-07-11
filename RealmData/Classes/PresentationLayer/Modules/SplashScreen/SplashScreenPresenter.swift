//
//  SplashScreenPresenter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//

import Foundation

protocol SplashScreenViewOutput: ViewOutput {
    func viewIsReady()
}

final class SplashScreenPresenter {
    
    // MARK: Public Properties
    
    weak var view: SplashScreenViewInput?
    var router: SplashScreenRouterInput?
    
    // MARK: Init
    
    init() {
    }
}

// MARK: - SplashScreenViewOutput

extension SplashScreenPresenter: SplashScreenViewOutput {
    
    func viewIsReady() {
        self.router?.setStartScreen()
    }
}
