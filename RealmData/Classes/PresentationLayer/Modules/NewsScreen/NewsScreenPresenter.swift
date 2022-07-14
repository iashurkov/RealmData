//
//  NewsScreenPresenter.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//

import Foundation

protocol NewsScreenViewOutput: ViewOutput {
    func didTapFavoriteButton(_ model: NewsItemModel?, isFavorite: Bool)
}

final class NewsScreenPresenter {
    
    // MARK: Public Properties
    
    weak var view: NewsScreenViewInput?
    var interactor: NewsScreenInteractorInput?
    var router: NewsScreenRouterInput?
    
    // MARK: Private Properties
    
    private var newsModel = NewsModel(result: [])
    
    // MARK: Init
    
    init() {
    }
}

// MARK: - NewsScreenViewOutput

extension NewsScreenPresenter: NewsScreenViewOutput {
    
    func viewDidLoad() {
        if let url = Bundle.main.url(forResource: "NewsMockData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NewsModel.self, from: data)
                
                self.view?.didOdtainData(with: jsonData)
                
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    func didTapFavoriteButton(_ model: NewsItemModel?, isFavorite: Bool) {
        guard let model = model else { return }
        
        // TODO: add model to Realm
        
        NotificationCenter.default.post(Notification(name: .updateDatabase))
    }
}

// MARK: - NewsScreenInteractorOutput

extension NewsScreenPresenter: NewsScreenInteractorOutput {
}
