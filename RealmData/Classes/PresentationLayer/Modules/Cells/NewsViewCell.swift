//
//  NewsViewCell.swift
//  RealmData
//
//  Created by iashurkov on 12.07.2022.
//

import UIKit

protocol NewsViewCellDelegate: AnyObject {
    func didTapReadmoreButton()
    func didTapFavoriteButton(for id: Int?, isFavorite: Bool)
}

final class NewsViewCell: UITableViewCell {
    
    // MARK: Public properties
    
    weak var delegate: NewsViewCellDelegate?
    
    // MARK: Private properties
    
    private enum Constants {
        static let sizeFontForTitle: CGFloat = 17
        static let sizeFontForDescription: CGFloat = 14
        
        static let separatorHeight: CGFloat = 1
        
        static let aboutOfNewsViewInset = UIEdgeInsets(top: 8, left: 16, bottom: 0, right: -16)
        
        static let numberOfLinesLabel = 2
        static let descriptionFont = UIFont.systemFont(ofSize: 14)
        
        static let dateLabelInset = UIEdgeInsets(top: 8, left: 16, bottom: -8, right: -16)
        static let dateLabelSize = CGSize(width: 0, height: 20)
        
        static let favoriteButtonInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: -16)
        static let favoriteButtonSize = CGSize(width: 22, height: 20)
        static let isNotFavorite = UIImage.init(systemName: "star")
        static let isFavorite = UIImage.init(systemName: "star.fill")
    }
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray
        
        return view
    }()
    
    private lazy var aboutOfNewsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: Constants.sizeFontForTitle)
        
        return label
    }()
    private var constraintHeightTitleLabel = NSLayoutConstraint()
    
    private lazy var descriptionLabel: ExpandableLabel = {
        let label = ExpandableLabel()
        label.font = Constants.descriptionFont
        label.lineBreakMode = .byWordWrapping
        label.delegate = self
        
        return label
    }()
    private var constraintHeightDescriptionLabel = NSLayoutConstraint()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.sizeFontForDescription)
        
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.isNotFavorite, for: .normal)
        button.addTarget(self,
                         action: #selector(self.didActionFavoriteButton),
                         for: .touchUpInside)
        
        return button
    }()
    
    private var model: NewsItemModel?
    private var isFavorite = false
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: nil)
        self.drawSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.drawSelf()
    }
    
    // MARK: Drawing
    
    private func drawSelf() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        
        self.addSubview(self.separatorView)
        self.addSubview(self.aboutOfNewsStackView)
        self.addSubview(self.dateLabel)
        self.addSubview(self.favoriteButton)
        
        let constraintsForSeparatorView = self.constraintsForSeparatorView()
        let constraintsForAboutOfNewsStackView = self.constraintsForAboutOfNewsStackView()
        let constraintsForDateLabel = self.constraintsForDateLabel()
        let constraintsForFavoriteButton = self.constraintsForFavoriteButton()
        
        NSLayoutConstraint.activate(
            constraintsForSeparatorView +
            constraintsForAboutOfNewsStackView +
            constraintsForDateLabel +
            constraintsForFavoriteButton
        )
    }
    
    // MARK: Get NSLayoutConstraints
    
    private func constraintsForSeparatorView() -> [NSLayoutConstraint] {
        let topAnchor = self.separatorView.topAnchor.constraint(equalTo: self.topAnchor)
        let leadingAnchor = self.separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailingAnchor = self.separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let heightAnchor = self.separatorView.heightAnchor.constraint(equalToConstant: Constants.separatorHeight)
        
        return [
            topAnchor, leadingAnchor, trailingAnchor, heightAnchor
        ]
    }
    
    private func constraintsForAboutOfNewsStackView() -> [NSLayoutConstraint] {
        let topAnchor = self.aboutOfNewsStackView.topAnchor.constraint(equalTo: self.separatorView.bottomAnchor, constant: Constants.aboutOfNewsViewInset.top)
        let leadingAnchor = self.aboutOfNewsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.aboutOfNewsViewInset.left)
        let trailingAnchor = self.aboutOfNewsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.aboutOfNewsViewInset.right)
        
        return [
            topAnchor, leadingAnchor, trailingAnchor
        ]
    }
    
    private func constraintsForDateLabel() -> [NSLayoutConstraint] {
        let topAnchor = self.dateLabel.topAnchor.constraint(equalTo: self.aboutOfNewsStackView.bottomAnchor, constant: Constants.dateLabelInset.top)
        let leadingAnchor = self.dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.dateLabelInset.left)
        let trailingAnchor = self.dateLabel.trailingAnchor.constraint(equalTo: self.favoriteButton.leadingAnchor, constant: Constants.dateLabelInset.right)
        let bottomAnchor = self.dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.dateLabelInset.bottom)
        let heightAnchor = self.dateLabel.heightAnchor.constraint(equalToConstant: Constants.dateLabelSize.height)
        
        return [
            topAnchor, leadingAnchor, trailingAnchor, bottomAnchor, heightAnchor
        ]
    }
    
    private func constraintsForFavoriteButton() -> [NSLayoutConstraint] {
        let topAnchor = self.favoriteButton.topAnchor.constraint(equalTo: self.aboutOfNewsStackView.bottomAnchor, constant: Constants.favoriteButtonInset.top)
        let trailingAnchor = self.favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.favoriteButtonInset.right)
        let heightAnchor = self.favoriteButton.heightAnchor.constraint(equalToConstant: Constants.favoriteButtonSize.height)
        let widthAnchor = self.favoriteButton.widthAnchor.constraint(equalToConstant: Constants.favoriteButtonSize.width)
        
        return [
            topAnchor, trailingAnchor, heightAnchor, widthAnchor
        ]
    }
    
    // MARK: Public methods
    
    func setup(with model: NewsItemModel) {
        self.model = model
        var arrayNSLayoutConstraint: [NSLayoutConstraint] = []
        
        if let title = model.title,
           title.isEmpty == false {
            self.titleLabel.text = model.title
            self.resizeTitleLabel()
            self.aboutOfNewsStackView.addArrangedSubview(self.titleLabel)
            
            arrayNSLayoutConstraint.append(self.constraintHeightTitleLabel)
        }
        
        if let description = model.description,
           description.isEmpty == false {
            self.descriptionLabel.setup(textForLabel: description,
                                        needNumberOfLines: 4)
            self.aboutOfNewsStackView.addArrangedSubview(self.descriptionLabel)
        }
        
        self.dateLabel.text = model.date
        
        let image = model.isFavorite == true
        ? Constants.isFavorite
        : Constants.isNotFavorite
        self.favoriteButton.setImage(image, for: .normal)
        
        NSLayoutConstraint.activate(arrayNSLayoutConstraint)
    }
    
    // MARK: Private methods
    
    @objc private func didActionFavoriteButton(sender: UIButton) {
        self.isFavorite.toggle()
        
        let image = self.isFavorite
        ? Constants.isFavorite
        : Constants.isNotFavorite
        
        UIView.transition(with: sender as UIView,
                          duration: 0.15,
                          options: .transitionFlipFromRight,
                          animations: {
            sender.setImage(image, for: .normal)
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            
            self.delegate?.didTapFavoriteButton(for: self.model?.id,
                                                isFavorite: self.isFavorite)
        })
    }
    
    // MARK: Get new height title and description
    
    private func resizeTitleLabel() {
        let height = self.titleLabel.calculateHeight(with: UIScreen.main.bounds.width - (Constants.aboutOfNewsViewInset.left + CGFloat(abs(Int(Constants.aboutOfNewsViewInset.right)))),
                                                     text: self.titleLabel.text,
                                                     font: self.titleLabel.font,
                                                     lineHeightMultiple: 1.0)
        self.constraintHeightTitleLabel = self.titleLabel.heightAnchor.constraint(equalToConstant: height)
    }
    
    private func resizeDescriptionLabel() {
        let height = self.descriptionLabel.calculateHeight(with: UIScreen.main.bounds.width - (Constants.aboutOfNewsViewInset.left + CGFloat(abs(Int(Constants.aboutOfNewsViewInset.right)))),
                                                           text: self.descriptionLabel.text,
                                                           font: self.descriptionLabel.font,
                                                           lineHeightMultiple: 1.0)
        self.constraintHeightDescriptionLabel = self.descriptionLabel.heightAnchor.constraint(equalToConstant: height)
    }
}

// MARK: - ExpandableLabelDelegate

extension NewsViewCell: ExpandableLabelDelegate {
    
    func didUpdateView(with durationAnimation: CGFloat) {
        self.resizeDescriptionLabel()
        
        UIView.animate(withDuration: durationAnimation) {
            self.descriptionLabel.layoutIfNeeded()
            self.layoutIfNeeded()
        }
        
        self.delegate?.didTapReadmoreButton()
    }
}
