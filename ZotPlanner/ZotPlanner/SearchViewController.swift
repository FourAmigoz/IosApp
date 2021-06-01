import UIKit

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var schoolTerm: UITextField!
    @IBOutlet weak var schoolDepartment: UITextField!
    @IBOutlet weak var schoolGE: UITextField!
    
    let APIURL = "https://damp-brushlands-74834.herokuapp.com/"

    let departments = ["EECS","ICS","CS"]
    let terms = [ "2021 Fall","2021 Spring"]
    let genEduc = ["GE-1A","GE-1B","GE-2","GE-3","GE-4","GE-5A","GE-5B","GE-6","GE-7","GE-8"]
    
    var termPickerView = UIPickerView()
    var departmentPickerView = UIPickerView()
    var gePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolTerm.inputView = termPickerView
        schoolDepartment.inputView = departmentPickerView
        schoolGE.inputView = gePickerView
        
        termPickerView.dataSource = self
        termPickerView.delegate = self
        departmentPickerView.dataSource = self
        departmentPickerView.delegate = self
        gePickerView.dataSource = self
        gePickerView.delegate = self
        
        
        termPickerView.tag = 1
        departmentPickerView.tag = 2
        gePickerView.tag = 3
        
        schoolGE.textAlignment = .center
        schoolDepartment.textAlignment = .center
        schoolTerm.textAlignment = .center
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return terms.count
        case 2:
            return departments.count
        case 3:
            return genEduc.count
        default:
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return terms[row]
        case 2:
            return departments[row]
        case 3:
            return genEduc[row]
        default:
            return "Data not found"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            schoolTerm.text = terms[row]
            schoolTerm.resignFirstResponder()
        case 2:
            schoolDepartment.text = departments[row]
            schoolDepartment.resignFirstResponder()
        case 3:
            schoolGE.text = genEduc[row]
            schoolGE.resignFirstResponder()
        default:
            return
        }       
    }
}
