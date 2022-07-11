//
//  UIViewController.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//

import UIKit

protocol ModuleTransitionHandler where Self: UIViewController {
    
}

extension ModuleTransitionHandler {
    
    func push<ModuleType: Assembly>(with model: TransitionModel, openModuleType: ModuleType.Type) {
        let view = ModuleType.assembleModule(with: model)
        self.navigationController?.pushViewController(view, animated: true)
    }
}

extension UIViewController: ModuleTransitionHandler {
    
    @objc func popModule() {
        self.navigationController?.popViewController(animated: true)
    }
}
