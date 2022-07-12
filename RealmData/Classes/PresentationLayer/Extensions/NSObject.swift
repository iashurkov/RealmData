//
//  NSObject.swift
//  RealmData
//
//  Created by iashurkov on 12.07.2022.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return String(describing: type(of: self))
    }
}
