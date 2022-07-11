//
//  NewsScreenViewController.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//

import UIKit

protocol NewsScreenViewInput: AnyObject {
}

final class NewsScreenViewController: UIViewController {
    
    // MARK: Public Properties
    
    var presenter: NewsScreenViewOutput?

     // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - NewsScreenViewInput

extension NewsScreenViewController: NewsScreenViewInput {
}
