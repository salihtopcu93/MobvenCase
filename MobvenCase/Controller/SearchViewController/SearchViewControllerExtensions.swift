//
//  SearchViewControllExtensions.swift
//  MobvenCase
//
//  Created by salih topcu on 17.04.2019.
//  Copyright © 2019 salih topcu. All rights reserved.
//

import UIKit

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
