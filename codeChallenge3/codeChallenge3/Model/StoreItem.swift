//
//  StoreItem.swift
//  codeChallenge3
//
//  Created by Douglas Patterson on 5/20/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import Foundation

struct StoreItems: Codable {
    let results: [StoreItem]
}

struct StoreItem: Codable {
    
    var title: String
    var year: String
    var imdbID: String
    var type: String
    var poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: CodingKeys.title)
        year = try values.decode(String.self, forKey: CodingKeys.year)
        imdbID = try values.decode(String.self, forKey: CodingKeys.imdbID)
        type = try values.decode(String.self, forKey: CodingKeys.type)
        poster = try values.decode(String.self, forKey: CodingKeys.poster)
        
    }
}
