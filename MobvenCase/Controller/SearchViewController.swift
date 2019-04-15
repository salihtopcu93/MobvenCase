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
    
    
    var viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func searchButton(_ sender: Any) {
        if (movieNameTextField.text?.isEmpty)! {
            print("Boş bırakmayınız")
        }else {
            viewModel.getMovies(name: movieNameTextField.text!, type: typeTextField.text, year: yearTextField!.text)
        }
    }
    @IBAction func typeTextFieldEditingDidBegin(_ sender: UITextField) {
        typeTextField.resignFirstResponder()
        pickerView.isHidden = false
        doneButtonOutlet.isHidden = false
        
    }
    @IBAction func doneButton(_ sender: Any) {
        pickerView.isHidden = true
        doneButtonOutlet.isHidden = true
    }
    
    


}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

extension SearchViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = viewModel.pickerData[row]
        typeTextField.text = selectedValue
    }
    
}

