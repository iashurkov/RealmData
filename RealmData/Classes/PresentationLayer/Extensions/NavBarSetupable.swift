//
//  NavBarSetupable.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//

import UIKit

protocol NavBarSetupable {
    var navigationBar: UINavigationBar? { get }
    
    func setupNavigationBar()
}

extension NavBarSetupable where Self: UIViewController {
    
    var navigationBar: UINavigationBar? {
        return navigationController?.navigationBar
    }
    
    private func setNavBarAppearance() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.shadowImage = nil
            navBarAppearance.shadowColor = nil
            navBarAppearance.backgroundColor = Colors.gray
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
            
            self.navigationBar?.standardAppearance = navBarAppearance
        }
    }
    
    private func setBackBarButtonItemTitle(with title: String) {
        let item = UIBarButtonItem(title: title,
                                   style: .plain,
                                   target: self,
                                   action: #selector(self.popModule))
        self.navigationItem.backBarButtonItem = item
    }
    
    func setupNavigationBar() {
        self.navigationBar?.tintColor = Colors.black
        self.navigationBar?.backgroundColor = Colors.gray
        
        self.setNavBarAppearance()
        self.setBackBarButtonItemTitle(with: "")
        
        let fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        let font = UIFont.systemFont(ofSize: fontSize,
                                     weight: .bold)
        let attributes = [NSAttributedString.Key.foregroundColor: Colors.black,
                          NSAttributedString.Key.font: font]
        
        self.navigationBar?.prefersLargeTitles = true
        self.navigationBar?.largeTitleTextAttributes = attributes
        self.navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.black]
        self.navigationItem.largeTitleDisplayMode = .automatic
    }
}
