//
//  News.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 05.09.2022.
//

import Foundation

struct News: Decodable, Hashable {
    var results : [Result]?
}

struct Result: Decodable, Hashable {
    var media : [Media]?
    var title : String
    var url : URL?
    var uuid: UUID?
    
    init(with model: NewsEntity) {
        self.title = model.titleNewsEntity
        self.url = model.imageNewsEntity
        self.uuid = model.id
    }
}

struct Media: Decodable, Hashable {
    var mediametadata : [MediaMetadata]?

    enum CodingKeys: String, CodingKey {
        case mediametadata = "media-metadata"
    }
}

struct MediaMetadata: Decodable, Hashable {
    var url : String?
}
