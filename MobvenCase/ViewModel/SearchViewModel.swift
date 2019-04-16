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
    
        wsProvider.request(.search(name: name, type: type, page: page, year: year)) { (response) in
            
            switch response {
            case .failure(let err):
                print(err)
            case .success(let value):
                let data = value.data
                
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
    }
    
    public func setLoading (_  isLoading : Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
    }

    }
