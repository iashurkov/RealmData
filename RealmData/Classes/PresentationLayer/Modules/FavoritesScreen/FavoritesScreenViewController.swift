//
//  FavoritesScreenViewController.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  

import UIKit
import RealmSwift

protocol FavoritesScreenViewInput: AnyObject {
    func didOdtainData(with models: [NewsItemModel]?)
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
    
    private var model: [NewsItemModel]?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = Constant.FavoritesTabBarItem.title
        
        self.setupNavigationBar()
        self.drawSelf()
        
        self.presenter?.viewDidLoad()
    }
    
    // MARK: Drawing
    
    private func drawSelf() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash.fill"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(self.didTapRightBarButton))
        
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
    
    @objc private func didTapRightBarButton() {
        let alert = UIAlertController(title: "Warning",
                                      message: "Do you really want to delete all the data?",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: UIAlertAction.Style.default) { [weak self] _ in
            self?.presenter?.removeAllItems()
        })
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: UIAlertAction.Style.cancel,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension FavoritesScreenViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let model = self.model?[indexPath.row] {
            let cell: NewsViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(with: model)
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell()
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
    
    func didOdtainData(with models: [NewsItemModel]?) {
        self.model = models
        self.tableView.reloadData()
    }
}
