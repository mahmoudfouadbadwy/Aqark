//
//  FirstScreenViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import Foundation
class FirstScreenViewController: UIViewController {
    
    @IBOutlet weak var rolesPicker: UIPickerView!
    var roles : [String] = [String]()
    var userRole : String = "User"
    var signUp: SignUpView!
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.title = "Role".localize
        self.view.backgroundColor = UIColor(rgb: 0xf1faee)
        self.rolesPicker.backgroundColor = UIColor(rgb: 0xf1faee)
        rolesPicker.delegate = self
        rolesPicker.dataSource = self
        roles = ["User","Lawyer","Interior Designer"]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        signUp = nil
    }
    
    @IBAction func submit(_ sender: Any) {
          signUp = SignUpView()
          signUp.role = userRole
         self.navigationController?.pushViewController(signUp, animated: true)
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
        userRole = roles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: roles[row].localize, attributes: [NSAttributedString.Key.foregroundColor:UIColor(rgb: 0x457b9d)])
    }
}
