//
//  FavoritesScreenViewController.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  
//

import UIKit
import RealmSwift

protocol FavoritesScreenViewInput: AnyObject {
    func didOdtainData(with models: [NewsRealmModel]?)
}

final class FavoritesScreenViewController: UIViewController, NavBarSetupable {
    
    // MARK: Public Properties
    
    var presenter: FavoritesScreenViewOutput?
    
    // MARK: Private Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cellTypes: [NewsViewCell.self])
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    private var model: [NewsRealmModel]?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = Constant.FavoritesTabBarItem.title
        
        self.setupNavigationBar()
        self.drawSelf()
    }
    
    // MARK: Drawing
    
    private func drawSelf() {
        self.view.addSubview(self.tableView)
        
        let constraintsForTableView = self.constraintsForTableView()
        
        NSLayoutConstraint.activate(
            constraintsForTableView
        )
    }
    
    // MARK: Get NSLayoutConstraints
    
    private func constraintsForTableView() -> [NSLayoutConstraint] {
        let topAnchor = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let trailingAnchor = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let leadingAnchor = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let bottomAnchor = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        return [
            topAnchor, trailingAnchor, leadingAnchor, bottomAnchor
        ]
    }
    
    // MARK: Private methods
    
    private func forceUpdateTableView() {
        self.tableView.beginUpdates()
        self.tableView.layoutIfNeeded()
        self.tableView.endUpdates()
    }
}

// MARK: - UITableViewDataSource

extension FavoritesScreenViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("[ ## ] RELOAD table view : count = \(self.model?.count ?? 0)")
        
        return self.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        
        if let model = self.model?[indexPath.row] {
            let newsModel = NewsItemModel.init(id: model.id,
                                               title: model.title,
                                               description: model.descriptionNews,
                                               date: model.date,
                                               isFavorite: model.isFavorite)
            
            cell.setup(with: newsModel)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoritesScreenViewController: UITableViewDelegate {
    
}

// MARK: - NewsViewCellDelegate

extension FavoritesScreenViewController: NewsViewCellDelegate {
    
    func didTapReadmoreButton() {
        self.forceUpdateTableView()
    }
    
    func didTapFavoriteButton(for id: Int?, isFavorite: Bool) {
        self.presenter?.didTapFavoriteButton(for: id,
                                             isFavorite: isFavorite)
    }
}

// MARK: - FavoritesScreenViewInput

extension FavoritesScreenViewController: FavoritesScreenViewInput {
    
    func didOdtainData(with models: [NewsRealmModel]?) {
        self.model = models
        self.tableView.reloadData()
    }
}
