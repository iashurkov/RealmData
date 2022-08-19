//
//  Realm.swift
//  RealmData
//
//  Created by iashurkov on 17.08.2022.
//

import Foundation
import RealmSwift

extension Realm {
    
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
