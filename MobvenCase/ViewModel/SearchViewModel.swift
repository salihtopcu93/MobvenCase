//
//  SearchViewModel.swift
//  MobvenCase
//
//  Created by salih topcu on 15.04.2019.
//  Copyright © 2019 salih topcu. All rights reserved.
//

import Foundation
import Alamofire

protocol SearchViewDelegate: class {
    func updatedList()
}

class SearchViewModel {
    var result : Movie?
    var delegate: SearchViewDelegate?
    var pickerData: [String] = ["Movie","Series","Episode"]
    var pagePickerData : [Int] = []

    
    func getMovies(name: String, type: String?, year: String?, page: String?){
        setLoading(true)
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
    
        let baseUrlString: String = "http://www.omdbapi.com/"
        
        Alamofire.request(baseUrlString, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON
            { (response) in
                print(response.request)
                guard let data = response.data else {return}
                
                do {
                    let result = try JSONDecoder().decode(Movie.self, from: data)
                    
                    self.result = result
                    
                    let pageCount = (Int(result.totalResults)!  / 10) + 1
                    
                    for page in 1...pageCount {
                        self.pagePickerData.append(page)
                    }
                    
                    self.delegate?.updatedList()
                    
                } catch let error {
                    print(error)
                }
                self.setLoading(false)
        }
    }
    
    public func setLoading (_  isLoading : Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
    }

    }
