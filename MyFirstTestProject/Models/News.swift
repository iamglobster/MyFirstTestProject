//
//  News.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 05.09.2022.
//

import Foundation

struct News: Decodable, Hashable {

    var copyright : String?
    var numResults : Int?
    var results : [Result]?
    var status : String?
}

struct Result: Decodable, Hashable {

    var abstractField : String?
    var adxKeywords : String?
    var assetId : Int?
    var byline : String?
    var desFacet : [String]?
    var etaId : Int?
    var geoFacet : [String]?
    var id : Int?
    var media : [Media]?
    var nytdsection : String?
    var orgFacet : [String]?
    var perFacet : [String]?
    var publishedDate : String?
    var section : String?
    var source : String?
    var subsection : String?
    var title : String?
    var type : String?
    var updated : String?
    var uri : String?
    var url : String?
    var image: Data?
    var isFavoreiteNews: Bool?
    
    init(title: String, image: Data, isFavoreiteNews: Bool) {
        self.title = title
        self.image = image
        self.isFavoreiteNews = isFavoreiteNews
    }
}

struct Media: Decodable, Hashable {

    var approvedForSyndication : Int?
    var caption : String?
    var copyright : String?
    var mediametadata : [MediaMetadata]?
    var subtype : String?
    var type : String?

    enum CodingKeys: String, CodingKey {
        case mediametadata = "media-metadata"
    }
}

struct MediaMetadata: Decodable, Hashable {

    var format : String?
    var height : Int?
    var url : String?
    var width : Int?
}
