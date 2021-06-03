import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    @IBOutlet weak var schoolTerm: UITextField!
    @IBOutlet weak var schoolDepartment: UITextField!
    @IBOutlet weak var schoolGE: UITextField!
    
    var termPickerView = UIPickerView()
    var departmentPickerView = UIPickerView()
    var gePickerView = UIPickerView()
    
    let APIURL = "https://damp-brushlands-74834.herokuapp.com/"
    
    var readableGEs: [String] = []
    var APIGEs: [String] = []
    var GEDict: [String: String] = [:]
    
    var readableTerms: [String] = []
    var APITerms: [String] = []
    var termDict: [String: String] = [:]
    
    var readableDepartments: [String] = []
    var APIDepartments: [String] = []
    var departmentDict: [String: String] = [:]
    
    
    func setUpPickerViews() {
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
    
    
    func setUpAPIInfo() {
        do {
            readableGEs = try String(contentsOfFile: Bundle.main.path(forResource: "readableGEs", ofType: "txt")!, encoding: String.Encoding.utf8).components(separatedBy: "\n")
            APIGEs = try String(contentsOfFile: Bundle.main.path(forResource: "APIGEs", ofType: "txt")!, encoding: String.Encoding.utf8).components(separatedBy: "\n")
            readableTerms = try String(contentsOfFile: Bundle.main.path(forResource: "readableTerms", ofType: "txt")!, encoding: String.Encoding.utf8).components(separatedBy: "\n")
            APITerms = try String(contentsOfFile: Bundle.main.path(forResource: "APITerms", ofType: "txt")!, encoding: String.Encoding.utf8).components(separatedBy: "\n")
            readableDepartments = try String(contentsOfFile: Bundle.main.path(forResource: "readableDepartments", ofType: "txt")!, encoding: String.Encoding.utf8).components(separatedBy: "\n")
            APIDepartments = try String(contentsOfFile: Bundle.main.path(forResource: "APIDepartments", ofType: "txt")!, encoding: String.Encoding.utf8).components(separatedBy: "\n")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        GEDict = Dictionary(uniqueKeysWithValues: zip(readableGEs, APIGEs))
        termDict = Dictionary(uniqueKeysWithValues: zip(readableTerms, APITerms))
        departmentDict = Dictionary(uniqueKeysWithValues: zip(readableDepartments, APIDepartments))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAPIInfo()
        setUpPickerViews()
    }
    
    
    @IBAction func callAPI(_ sender: Any) {
        // There should be no way that we're asking for translation
        // on something that's not in the dicts, so let's have it
        // cause an exception and abort if we get back nil.
        let parameters = [
            "term": termDict[schoolTerm.text!],
            "department": departmentDict[schoolDepartment.text!],
            "GE": GEDict[schoolGE.text!]
        ]
        
        AF.request(APIURL, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response)
        }
    }
}

extension SearchViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return readableTerms.count
        case 2:
            return readableDepartments.count
        case 3:
            return readableGEs.count
        default:
            return 1
        }
    }
}

extension SearchViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return readableTerms[row]
        case 2:
            return readableDepartments[row]
        case 3:
            return readableGEs[row]
        default:
            return "Data not found"
        }
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            schoolTerm.text = readableTerms[row]
            schoolTerm.resignFirstResponder()
        case 2:
            schoolDepartment.text = readableDepartments[row]
            schoolDepartment.resignFirstResponder()
        case 3:
            schoolGE.text = readableGEs[row]
            schoolGE.resignFirstResponder()
        default:
            return
        }
    }
}
