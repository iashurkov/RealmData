//
//  NewsScreenViewController.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  

import UIKit

protocol NewsScreenViewInput: AnyObject {
    func didOdtainData(with model: NewsModels)
}

final class NewsScreenViewController: UIViewController, NavBarSetupable {
    
    // MARK: Public Properties
    
    var presenter: NewsScreenViewOutput?
    
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
    
    private var model: NewsModels?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = Constant.NewsTabBarItem.title
        
        self.setupNavigationBar()
        self.drawSelf()
        
        self.presenter?.viewDidLoad()
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

extension NewsScreenViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        
        if let model = self.model?.result[indexPath.row] {
            cell.setup(with: model)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NewsScreenViewController: UITableViewDelegate {
    
}

// MARK: - NewsViewCellDelegate

extension NewsScreenViewController: NewsViewCellDelegate {
    
    func didTapReadmoreButton() {
        self.forceUpdateTableView()
    }
    
    func didTapFavoriteButton(for id: Int?, isFavorite: Bool) {
        self.presenter?.didTapFavoriteButton(for: id,
                                             isFavorite: isFavorite)
    }
}

// MARK: - NewsScreenViewInput

extension NewsScreenViewController: NewsScreenViewInput {
    
    func didOdtainData(with model: NewsModels) {
        self.model = model
        self.tableView.reloadData()
    }
}
