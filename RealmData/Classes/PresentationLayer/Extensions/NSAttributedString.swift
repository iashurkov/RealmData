//
//  NSAttributedString.swift
//  RealmData
//
//  Created by iashurkov on 12.07.2022.
//

import UIKit

extension NSAttributedString {
    
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        let height = ceilf(Float(boundingBox.size.height))
        
        return CGFloat(height)
    }
    
    func height(withConstrainedWidth width: CGFloat, maxLinesNumber: Int) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        guard let font = attribute(.font, at: 0, effectiveRange: nil) as? UIFont else { return 0 }
        
        let maxHeight = font.lineHeight * CGFloat(maxLinesNumber)
        let height = ceil(fmin(boundingBox.size.height, maxHeight))
        
        return height
    }
}
