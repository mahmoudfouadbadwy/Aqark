//
//  SignUpView.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
//MARK:- Life cycle and Properties
class SignUpView: UIViewController  {
    @IBOutlet  weak var phoneNumber: UITextField!
    @IBOutlet  weak var username: UITextField!
    @IBOutlet  weak var email: UITextField!
    @IBOutlet  weak var password: UITextField!
    @IBOutlet  weak var confirmPassword: UITextField!
    @IBOutlet  weak var company: UITextField!
    @IBOutlet  weak var countries: UIPickerView!
    var role:String = "user"
    var accountViewModel:AccountViewModel!
    let countriesPicker:[String] = Countries().countries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sign Up".localize
        setupViews(as: role)
        setIcons()
        setTextFieldsDelegate()
        setPickerDelegates()
        setTappedGesture()
    }

    @IBAction func createAccount(_ sender: Any) {
       guard let email = email.text ,
             let password = password.text,
             let confirm = confirmPassword.text,
             let username = username.text,
             let phone = phoneNumber.text,
             let company = company.text
             else { return }
        switch self.role.lowercased() {
        case "user":
                createUserAccount(email: email, password:password,confirm: confirm,username:username)
        default:createServiceAccount(email: email, password: password, confirm: confirm, username: username, phone: phone, country: countriesPicker[countries.selectedRow(inComponent: 0)], company: company)
        }
    }
}




