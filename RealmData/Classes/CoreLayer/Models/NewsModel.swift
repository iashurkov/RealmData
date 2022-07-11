//
//  NewsModel.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//

import Foundation

struct NewsModel: Codable {
    var result: [NewsItemModel]
    
    enum CodingKeys: String, CodingKey {
        case result
    }
}

struct NewsItemModel: Codable, Equatable {
    let id: Int
    let title: String
    let description: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, date
    }
}
