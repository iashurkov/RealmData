//
//  SplashScreenViewController.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//  

import UIKit

protocol SplashScreenViewInput: AnyObject {
}

final class SplashScreenViewController: UIViewController {
    
    // MARK: Public Properties
    
    var presenter: SplashScreenViewOutput?
    
    // MARK: Private Properties
    
    private enum Constants {
        static let sizeFontForTitle: CGFloat = 18
        static let titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: -8, right: -30)
        
        static let sizeFontForDescription: CGFloat = 16
        static let subTitleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: -16, right: -30)
        
        static let cornerRadiusConfirmButton: CGFloat = 8
        static let sizeButtonConfirm = CGSize(width: 200, height: 34)
        static let buttonConfirmEdgeInsets = UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.black
        label.font = UIFont.boldSystemFont(ofSize: Constants.sizeFontForTitle)
        label.textAlignment = .center
        
        label.text = "Choice"
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Constants.sizeFontForDescription)
        label.textAlignment = .center
        
        label.text = "which storage system will we use?"
        
        return label
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: self.storageSystem)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.tintColor = Colors.blue
        control.backgroundColor = Colors.gray
        
        return control
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.gray
        button.tintColor = Colors.black
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.cornerRadiusConfirmButton
        
        button.addTarget(self,
                         action: #selector(self.didTapConfirmButton),
                         for: .touchUpInside)
        
        button.setTitleColor(Colors.black, for: .normal)
        button.setTitle("Confirm", for: .normal)
        
        return button
    }()
    
    private let storageSystem = ["Realm", "CoreData"]
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.drawSelf()
        
        let useRealmStorage = UserDefaults.standard.bool(forKey: "useRealmStorage")
        self.segmentControl.selectedSegmentIndex = useRealmStorage ? 0 : 1
    }
    
    // MARK: Drawing
    
    private func drawSelf() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.subTitleLabel)
        self.view.addSubview(self.segmentControl)
        self.view.addSubview(self.confirmButton)
        
        let constraintsForTitleLabel = self.constraintsForTitleLabel()
        let constraintsForSubTitleLabel = self.constraintsForSubTitleLabel()
        let constraintsForSegmentControl = self.constraintsForSegmentControl()
        let constraintsForButtonConfirm = self.constraintsForButtonConfirm()
        
        NSLayoutConstraint.activate(
            constraintsForTitleLabel +
            constraintsForSubTitleLabel +
            constraintsForSegmentControl +
            constraintsForButtonConfirm
        )
    }
    
    // MARK: Get NSLayoutConstraints
    
    private func constraintsForTitleLabel() -> [NSLayoutConstraint] {
        let trailingAnchor = self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Constants.titleEdgeInsets.right)
        let leadingAnchor = self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.titleEdgeInsets.left)
        let bottomAnchor = self.titleLabel.bottomAnchor.constraint(equalTo: self.subTitleLabel.topAnchor, constant: Constants.titleEdgeInsets.bottom)
        
        return [
            trailingAnchor, leadingAnchor, bottomAnchor
        ]
    }
    
    private func constraintsForSubTitleLabel() -> [NSLayoutConstraint] {
        let trailingAnchor = self.subTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Constants.subTitleEdgeInsets.right)
        let leadingAnchor = self.subTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.subTitleEdgeInsets.left)
        let bottomAnchor = self.subTitleLabel.bottomAnchor.constraint(equalTo: self.segmentControl.topAnchor, constant: Constants.subTitleEdgeInsets.bottom)
        
        return [
            trailingAnchor, leadingAnchor, bottomAnchor
        ]
    }
    
    private func constraintsForSegmentControl() -> [NSLayoutConstraint] {
        let centerXAnchor = self.segmentControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let centerYAnchor = self.segmentControl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        return [
            centerXAnchor, centerYAnchor
        ]
    }
    
    private func constraintsForButtonConfirm() -> [NSLayoutConstraint] {
        let centerXAnchor = self.confirmButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let topAnchor = self.confirmButton.topAnchor.constraint(equalTo: self.segmentControl.bottomAnchor, constant: Constants.buttonConfirmEdgeInsets.top)
        let heightAnchor = self.confirmButton.heightAnchor.constraint(equalToConstant: Constants.sizeButtonConfirm.height)
        let widthAnchor = self.confirmButton.widthAnchor.constraint(equalToConstant: Constants.sizeButtonConfirm.width)
        
        return [
            centerXAnchor, topAnchor, heightAnchor, widthAnchor
        ]
    }
    
    // MARK: Private methods
    
    @objc private func didTapConfirmButton() {
        let useRealmStorage = self.storageSystem[self.segmentControl.selectedSegmentIndex] == self.storageSystem[0]
        self.presenter?.confirmStorageSystem(with: useRealmStorage)
    }
}

// MARK: - SplashScreenViewInput

extension SplashScreenViewController: SplashScreenViewInput {
}
