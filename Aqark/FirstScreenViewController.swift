//
//  FirstScreenViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    @IBOutlet weak var rolesPicker: UIPickerView!
    var roles : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rolesPicker.delegate = self
        rolesPicker.dataSource = self
        roles = ["User","Lawyer","Interior Designer"]
    }
}

extension FirstScreenViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return roles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(roles[row])
    }
 
}
