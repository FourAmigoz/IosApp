//
//  SearchViewController.swift
//  ZotPlanner
//
//  Created by Humza Khan on 5/23/21.
//

import UIKit
import Alamofire
import PickerView

class SearchViewController: UIViewController {
    
    @IBOutlet weak var termPicker: PickerView!
    @IBOutlet weak var departmentPicker: PickerView!
    @IBOutlet weak var gePicker: PickerView!
    
    let APIURL = "https://damp-brushlands-74834.herokuapp.com/"
    let possibleTerms = [
        "2021 Fall",
        "2021 Spring"
    ]
    let possibleDepartments = [
        "EECS",
        "ICS",
        "CS"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        termPicker.dataSource = self
        termPicker.delegate = self
        
        let scrollingStyle: PickerView.ScrollingStyle
        let selectionStyle: PickerView.SelectionStyle
        
        termPicker.scrollingStyle = PickerView.ScrollingStyle(rawValue: 0)!
        termPicker.selectionStyle = PickerView.SelectionStyle(rawValue: 0)!
        
//        if let currentSelected = currentSelectedValue, let indexOfCurrentSelectedValue = numbers.index(of: currentSelected) {
//            examplePicker.currentSelectedRow = indexOfCurrentSelectedValue
//        }
        
        
//        departmentPicker.dataSource = self
//        departmentPicker.delegate = self
        
//        let parameters = [
//            "term": "2019 Fall",
//            "GE": "GE-2",
//            "instructorName": "Pattis"
//        ]
//        AF.request(APIURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
//            print(response)
//        }
    }
    
    // Call the API when the user clicks on search
    @IBAction func callAPI(_ sender: Any) {
        
    }

}

extension SearchViewController: PickerViewDataSource {
    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
        if pickerView == termPicker {
            return possibleTerms.count
//        } else if pickerView == departmentPicker {
//            return possibleDepartments.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: PickerView, titleForRow row: Int) -> String {
        if pickerView == termPicker {
            return possibleTerms[row]
//        } else if pickerView == departmentPicker {
//            return possibleDepartments[row]
        } else {
            return ""
        }
    }
}

extension SearchViewController: PickerViewDelegate {
    func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: PickerView, didSelectRow row: Int) {
        print("The selected item is \(possibleTerms[row])")
    }
    
    func pickerView(_ pickerView: PickerView, didTapRow row: Int) {
        print("The row \(row) was tapped by the user")
    }
    
    func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
        label.textAlignment = .center
        
        if highlighted {
            label.font = UIFont.systemFont(ofSize: 25.0)
            label.textColor = view.tintColor
        } else {
            label.font = UIFont.systemFont(ofSize: 15.0)
            label.textColor = .lightGray
        }
    }
}
