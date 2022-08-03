//
//  NewsModel.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//

import Foundation

struct NewsModels: Codable {
    var result: [NewsItemModel]
    
    enum CodingKeys: String, CodingKey {
        case result
    }
}

struct NewsItemModel: Codable, Equatable {
    let id: Int
    let title: String?
    let description: String?
    let date: String?
    var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, date, isFavorite
    }
}
