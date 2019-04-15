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
    
    let urlString: String = "http://www.omdbapi.com/?s=Batman&page=2&apikey=6dc0afb6"
    
    init() {
        getMovies(name: "Batman", type: "movie", year: "2016")
    }
    func getMovies(name: String, type: String?, year: String?){
        setLoading(true)
        
        Alamofire.request( urlString).responseJSON
            { (response) in
                guard let data = response.data else {return}
                
                do {
                    let result = try JSONDecoder().decode(Movie.self, from: data)
                    
                    self.result = result
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
