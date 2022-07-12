//
//  UITableView.swift
//  RealmData
//
//  Created by iashurkov on 12.07.2022.
//

import UIKit

extension UITableView {
    
    func register(cellTypes: [UITableViewCell.Type]) {
        cellTypes.forEach {
            let reuseIdentifier = $0.className
            register($0, forCellReuseIdentifier: reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let identifier = T.className
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}
