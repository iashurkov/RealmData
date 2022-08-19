//
//  SplashScreenPresenter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  

import Foundation

protocol SplashScreenViewOutput: ViewOutput {
    func confirmStorageSystem(with useRealmStorage: Bool)
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
    
    func confirmStorageSystem(with useRealmStorage: Bool) {
        StorageManager.shared.checkStorageSystem(with: useRealmStorage) {
            self.router?.setStartScreen()
        }
    }
}
