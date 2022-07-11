//
//  FavoriteScreenViewController.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//

import UIKit

protocol FavoriteScreenViewInput: AnyObject {
}

final class FavoriteScreenViewController: UIViewController {
    
    // MARK: Public Properties
    
    var presenter: FavoriteScreenViewOutput?

     // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - FavoriteScreenViewInput

extension FavoriteScreenViewController: FavoriteScreenViewInput {
}
