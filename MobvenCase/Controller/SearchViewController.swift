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
        if (movieNameTextField.text?.isEmpty)! {
            print("Boş bırakmayınız")
        }else {
            viewModel.getMovies(name: movieNameTextField.text!, type: typeTextField.text, year: yearTextField!.text, page: pagesTextField.text!)
            tableView.isHidden = false
            pagesTextField.isHidden = false
        }
    }
    @IBAction func typeTextFieldEditingDidBegin(_ sender: UITextField) {
        let pv = UIPickerView()
        pv.dataSource = self
        pv.delegate = self
        addToolBar(textField: sender)
        sender.inputView = pv
//        typeTextField.resignFirstResponder()
//        pickerView.isHidden = false
//        doneButtonOutlet.isHidden = false
//        isPagePickerSelected = false
//
//        pickerView.reloadAllComponents()
    }
    
    @IBAction func pagesTextFieldEditingDidBegin(_ sender: UITextField) {
        pagesTextField.resignFirstResponder()
        pickerView.isHidden = false
        doneButtonOutlet.isHidden = false
        isPagePickerSelected = true
        
        pickerView.reloadAllComponents()
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

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return viewModel.result?.search.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchTableViewCell
        let imageUrl = viewModel.result?.search[indexPath.row].poster
        let title = viewModel.result?.search[indexPath.row].title
        let subTitle = viewModel.result?.search[indexPath.row].type
        cell.setView(imageUrl: imageUrl ?? "", title: title ?? "", subTitle: subTitle ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        
        detailViewController.result = viewModel.result?.search[indexPath.row]
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
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
        if isPagePickerSelected {
            return viewModel.pagePickerData.count
        } else {
             return viewModel.pickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isPagePickerSelected {
            return String(viewModel.pagePickerData[row])
        } else {
            return viewModel.pickerData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isPagePickerSelected {
            let selectedValue = String(viewModel.pagePickerData[row])
            pagesTextField.text = selectedValue
        } else {
            let selectedValue = viewModel.pickerData[row]
            typeTextField.text = selectedValue
        }
    }
    
}

extension SearchViewController : SearchViewDelegate {
    func updatedList() {
        tableView.reloadData()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        typeTextField.resignFirstResponder()
        yearTextField.resignFirstResponder()
        pagesTextField.resignFirstResponder()
        movieNameTextField.resignFirstResponder()
        pickerView.isHidden = true
        doneButtonOutlet.isHidden = true
        
        return true

    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func addToolBar(textField: UITextField){
        var toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    @objc func donePressed(){
        view.endEditing(true)
    }
}


