//
//  ViewController.swift
//  ZotPlanner
//
//  Created by Humza Khan on 5/18/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AF.request("http://localhost:8081").response { response in
            debugPrint(response)
        }
    }


}

