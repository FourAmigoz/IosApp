//
//  SearchViewController.swift
//  ZotPlanner
//
//  Created by Humza Khan on 5/23/21.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var termPicker: UIPickerView!
    @IBOutlet weak var departmentPicker: UIPickerView!
    @IBOutlet weak var GEPicker: UIPickerView!
    
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
    
    // The number of picker components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Returns the number of rows in a given picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == termPicker {
            return possibleTerms.count
        } else if pickerView == departmentPicker {
            return possibleDepartments.count
        } else {
            return 1
        }
    }
    
    // Returns the String for a given row in a given picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == termPicker {
            return possibleTerms[row]
        } else if pickerView == departmentPicker {
            return possibleDepartments[row]
        } else {
            return ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        termPicker.dataSource = self
        termPicker.delegate = self
        departmentPicker.dataSource = self
        departmentPicker.delegate = self
        
        let parameters = [
            "term": "2019 Fall",
            "GE": "GE-2",
            "instructorName": "Pattis"
        ]
        AF.request(APIURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response)
        }
    }
    
    // Call the API when the user clicks on search
    @IBAction func callAPI(_ sender: Any) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


