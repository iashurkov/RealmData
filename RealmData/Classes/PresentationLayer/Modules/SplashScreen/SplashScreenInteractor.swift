//
//  SplashScreenInteractor.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  /
//

import Foundation


protocol SplashScreenInteractorInput {
}

protocol SplashScreenInteractorOutput: AnyObject {
}

final class SplashScreenInteractor {
    
    // MARK: - Public Properties
    
    weak var presenter: SplashScreenInteractorOutput?
    
    // MARK: Init
    
    init() {
    }
}

// MARK: - SplashScreenInteractorInput

extension SplashScreenInteractor: SplashScreenInteractorInput {
}
