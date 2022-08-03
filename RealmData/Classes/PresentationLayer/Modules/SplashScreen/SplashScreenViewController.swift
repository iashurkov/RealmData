//
//  SplashScreenViewController.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  

import UIKit

protocol SplashScreenViewInput: AnyObject {
}

final class SplashScreenViewController: UIViewController {
    
    // MARK: Public Properties
    
    var presenter: SplashScreenViewOutput?

     // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            self?.presenter?.viewIsReady()
        })
    }
}

// MARK: - SplashScreenViewInput

extension SplashScreenViewController: SplashScreenViewInput {
}
