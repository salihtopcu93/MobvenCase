//
//  SearchModel.swift
//  MobvenCase
//
//  Created by salih topcu on 15.04.2019.
//  Copyright © 2019 salih topcu. All rights reserved.
//

import Foundation

struct SearchModel {
    let title : String
    let year : String
    let type : String
    let poster : String
}

extension SearchModel : Decodable {
    enum SearchModelCodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
    
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: SearchModelCodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        year = try container.decode(String.self, forKey: .year)
        type = try container.decode(String.self, forKey: .type)
        poster = try container.decode(String.self, forKey: .poster)
 
    }
}
