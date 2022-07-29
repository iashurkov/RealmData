//
//  NewsRealmModel.swift
//  RealmData
//
//  Created by iashurkov on 28.07.2022.
//

import Foundation
import RealmSwift

final class NewsRealmModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var title: String?
    @objc dynamic var descriptionNews: String?
    @objc dynamic var date: String?
    @objc dynamic var isFavorite = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int,
                     title: String?,
                     descriptionNews: String?,
                     date: String?,
                     isFavorite: Bool) {
        self.init()
        self.id = id
        self.title = title
        self.descriptionNews = descriptionNews
        self.date = date
        self.isFavorite = isFavorite
    }
}
