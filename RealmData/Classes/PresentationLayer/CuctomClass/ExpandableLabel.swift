//
//  ExpandableLabel.swift
//  RealmData
//
//  Created by iashurkov on 12.07.2022.
//

import UIKit

protocol ExpandableLabelDelegate {
    func didUpdateView(with durationAnimation: CGFloat)
}

final class ExpandableLabel: UILabel {
    
    // MARK: Public Properties
    
    var delegate: ExpandableLabelDelegate?
    
    // MARK: Private Properties
    
    private var extendedText = String()
    private var collapsedNumberOfLines = 2
    
    private var moreButtonFont = UIFont()
    private var moreButtonColor = UIColor()
    private var titleReadmore = String()
    private var trailingReadmore = String()
    private var titleReadless = String()
    private var trailingReadless = String()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Public methods
    
    func setup(textForLabel: String,
               needNumberOfLines: Int) {
        self.extendedText = textForLabel
        self.collapsedNumberOfLines = needNumberOfLines
        
        self.moreButtonFont = UIFont.boldSystemFont(ofSize: 14.0)
        self.moreButtonColor = UIColor.systemBlue
        self.titleReadmore = "Readmore"
        self.trailingReadmore = "... "
        self.titleReadless = "Readless"
        self.trailingReadless = "\n"
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = needNumberOfLines
        self.text = textForLabel
        
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureAction(_ :)))
        self.addGestureRecognizer(tapGesture)
        
        self.changeStateToReadmore()
    }
    
    // MARK: Private methods
    
    private func changeStateToReadmore() {
        DispatchQueue.main.async {
            self.addReadmoreButton(for: self.extendedText,
                                   trailingText: self.trailingReadmore,
                                   moreText: self.titleReadmore,
                                   moreTextFont: self.moreButtonFont,
                                   moreTextColor: self.moreButtonColor)
            self.delegate?.didUpdateView(with: 0.1)
        }
    }
    
    private func changeStateToReadless() {
        self.addReadlessButton(for: self.extendedText,
                               trailingText: self.trailingReadless,
                               lessText: self.titleReadless,
                               lessTextFont: self.moreButtonFont,
                               lessTextColor: self.moreButtonColor)
    }
    
    @objc private func tapGestureAction(_ gesture: UITapGestureRecognizer) {
        guard let text = self.text else { return }
        
        let durationAnimation: CGFloat = 0.2
        let readmoreButton = (text as NSString).range(of: self.titleReadmore)
        let readlessButton = (text as NSString).range(of: self.titleReadless)
        
        if gesture.didTapAttributedTextInLabel(label: self,
                                               inRange: readmoreButton) {
            UIView.transition(with: self,
                              duration: durationAnimation,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                guard let self = self else { return }
                self.changeStateToReadless()
            }, completion: nil)
            self.numberOfLines = 0
        } else if gesture.didTapAttributedTextInLabel(label: self,
                                                      inRange: readlessButton) {
            UIView.transition(with: self,
                              duration: durationAnimation,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                guard let self = self else { return }
                self.changeStateToReadmore()
            }, completion: nil)
            self.numberOfLines = self.collapsedNumberOfLines
        }
        
        self.delegate?.didUpdateView(with: durationAnimation)
    }
}
