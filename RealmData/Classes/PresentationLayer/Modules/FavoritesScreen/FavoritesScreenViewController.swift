//
//  FavoritesScreenViewController.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//

import UIKit

protocol FavoritesScreenViewInput: AnyObject {
}

final class FavoritesScreenViewController: UIViewController, NavBarSetupable {
    
    // MARK: Public Properties
    
    var presenter: FavoritesScreenViewOutput?

     // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Constant.FavoritesTabBarItem.title
        
        self.view.backgroundColor = .white
        self.setupNavigationBar()
    }
}

// MARK: - FavoritesScreenViewInput

extension FavoritesScreenViewController: FavoritesScreenViewInput {
}
