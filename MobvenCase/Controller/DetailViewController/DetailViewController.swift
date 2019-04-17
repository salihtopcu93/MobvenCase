//
//  DetailViewController.swift
//  MobvenCase
//
//  Created by salih topcu on 16.04.2019.
//  Copyright © 2019 salih topcu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTypeLabel: UILabel!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailYearLabel: UILabel!
    
    var result: SearchModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    func setView(){
        detailImageView.kf.setImage(with: URL(string:  result.poster))
        detailTitleLabel.text = result.title
        detailTypeLabel.text = result.type
        detailYearLabel.text = result.year
    }
}
