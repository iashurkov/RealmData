//
//  NSNotification.swift
//  RealmData
//
//  Created by iashurkov on 14.07.2022.
//

import Foundation

extension NSNotification.Name {
    // Notification for favorite screen
    static let updateFavoriteList = NSNotification.Name("updateFavoriteList")
    
    // Notification for main screen
    static let unselectPost = NSNotification.Name("unselectPost")
    static let unselectAllPosts = NSNotification.Name("unselectAllPosts")
}
