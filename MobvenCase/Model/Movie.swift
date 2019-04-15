//
//  Movie.swift
//  MobvenCase
//
//  Created by salih topcu on 15.04.2019.
//  Copyright © 2019 salih topcu. All rights reserved.
//

import Foundation

struct Movie {
    let search : [SearchModel]
    let totalResults : String
    let response : String
}

extension Movie: Decodable {
    
    
    enum  MovieCodingKeys : String, CodingKey{
        case search = "Search"
        case totalResults
        case response = "Response"
    }
    
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        search = try container.decode([SearchModel].self, forKey: .search)
        totalResults = try container.decode(String.self, forKey: .totalResults)
        response = try container.decode(String.self, forKey: .response)
    }
}
