//
//  MobvenCaseService.swift
//  MobvenCase
//
//  Created by salih topcu on 16.04.2019.
//  Copyright © 2019 salih topcu. All rights reserved.
//

import Foundation
import Moya

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}
let wsProvider = MoyaProvider<SearchAPI>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

enum SearchAPI {
    case search(name: String, type: String?, page: String?, year: String?)
}

extension SearchAPI : TargetType {
    var baseURL: URL {
        return URL(string: "http://www.omdbapi.com/")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .search:
            return Data()
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters , encoding: URLEncoding.queryString)
    }
    
    var parameters: [String : Any] {
        switch self {
        case .search(let name, let type, let page, let year):
            var parameter = [String:Any]()
            parameter["s"] = name
            parameter["apikey"] = "6dc0afb6"
            
            if let type = type{
                parameter["type"] = type
            }
            if let year = year {
                parameter["y"] = year
            }
            if let page = page {
                parameter["page"] = page
            }
            
            return parameter
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
