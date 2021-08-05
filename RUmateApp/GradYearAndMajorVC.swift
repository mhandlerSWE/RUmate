//
//  GradYearAndMajorVC.swift
//  RUmateApp
//
//  Created by Max Handler on 8/4/21.
//

import UIKit

class GradYearAndMajorVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var majorPicker: UIPickerView!
    
    
    //dummy data
    var years: [String] = ["2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028"]
    var majors: [String] = ["Biology", "Computer Science", "Engineering", "Finance", "Economics", "English", "Other"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //appearance
        majorPicker.layer.cornerRadius = 10
        majorPicker.layer.masksToBounds = true
        yearPicker.layer.cornerRadius = 10
        yearPicker.layer.masksToBounds = true
                
        //data assignment
        self.majorPicker.delegate = self
        self.majorPicker.dataSource = self
        self.yearPicker.delegate = self
        self.yearPicker.dataSource = self
    }
    
    //number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    //number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == yearPicker {
            return years.count
        }
        else {
            return majors.count
        }
    }
    
    //the datat to return the row and component(column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == yearPicker {
            return years[row]
        }
        else {
            return majors[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //m
    }
    
    
}
