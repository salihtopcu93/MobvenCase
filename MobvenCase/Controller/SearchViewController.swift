//
//  ViewController.swift
//  MobvenCase
//
//  Created by salih topcu on 15.04.2019.
//  Copyright © 2019 salih topcu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var viewModel : SearchViewModel!
    
    func configureModel() {
        self.viewModel = SearchViewModel.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureModel()
    }


}

