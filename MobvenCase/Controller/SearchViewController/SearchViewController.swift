//
//  ViewController.swift
//  MobvenCase
//
//  Created by salih topcu on 15.04.2019.
//  Copyright © 2019 salih topcu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var movieNameTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pagesTextField: UITextField!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    @IBOutlet weak var yearButtonOutlet: UIButton!
    @IBOutlet weak var typeButtonOutlet: UIButton!
    
    var viewModel = SearchViewModel()
    var yearIsSelected: Bool = false
    var typeIsSelected: Bool = false
    let tickActiveImage: UIImage = UIImage(named: "tickPassive")!
    let tickPassive: UIImage = UIImage(named: "oval15")!
    
    var isPagePickerSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        disabled()
    }
    
    func disabled() {
        yearTextField.isEnabled = false
        typeTextField.isEnabled = false
        pagesTextField.isHidden = true
        tableView.isHidden = true
    }
    @IBAction func searchButton(_ sender: Any) {
       
        guard let trimControll = movieNameTextField.text?.trimmingCharacters(in: .whitespaces) else {return}
        
        if (trimControll.isEmpty) {
            print("Boş bırakmayınız")
            showAlert()
        }else {
            viewModel.getMovies(name: movieNameTextField.text!, type: typeTextField.text, year: yearTextField!.text, page: pagesTextField.text!)
            tableView.isHidden = false
            pagesTextField.isHidden = false
        }
    }
    @IBAction func typeTextFieldEditingDidBegin(_ sender: UITextField) {
            pickerView(sender: sender, PickerSelected: false)
    }
    
    @IBAction func pagesTextFieldEditingDidBegin(_ sender: UITextField) {
            pickerView(sender: sender, PickerSelected: true)

    }
    
    func pickerView(sender : UITextField, PickerSelected : Bool){
        let pv = UIPickerView()
        pv.dataSource = self
        pv.delegate = self
        addToolBar(textField: sender)
        sender.inputView = pv
        isPagePickerSelected = PickerSelected
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: "Dikkat", message: "Lütfen isim alanını boş bırakmayınız.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func doneButton(_ sender: Any) {
        pickerView.isHidden = true
        doneButtonOutlet.isHidden = true
    }
    @IBAction func yearButton(_ sender: Any) {
        
        if yearIsSelected {
            yearButtonOutlet.setImage(tickPassive, for: .normal)
            yearTextField.isEnabled = false
            yearTextField.text = ""
        } else {
            yearButtonOutlet.setImage(tickActiveImage, for: .normal)
            yearTextField.isEnabled = true
        }
        yearIsSelected = !yearIsSelected
    }
    
    @IBAction func typeButton(_ sender: Any) {
        if typeIsSelected {
            typeButtonOutlet.setImage(tickPassive, for: .normal)
            typeTextField.isEnabled = false
            typeTextField.text = ""
        } else {
            typeButtonOutlet.setImage(tickActiveImage, for: .normal)
            typeTextField.isEnabled = true
        }
        typeIsSelected = !typeIsSelected
    }
}



