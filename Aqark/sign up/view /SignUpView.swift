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
    @IBOutlet  weak var phoneNumber: CustomTextField!
    @IBOutlet  weak var username: CustomTextField!
    @IBOutlet  weak var email: CustomTextField!
    @IBOutlet  weak var password: CustomTextField!
    @IBOutlet  weak var confirmPassword: CustomTextField!
    @IBOutlet  weak var company: CustomTextField!
    @IBOutlet  weak var countries: UIPickerView!
    var role:String = "user"
    var accountViewModel:AccountViewModel!
    let countriesPicker:[String] = Countries().countries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sign Up".localize
        self.view.backgroundColor = UIColor(rgb: 0xf1faee)
        self.countries.backgroundColor = UIColor(rgb: 0xf1faee)
        setupViews(as: role)
        setIcons()
        setTextFieldsDelegate()
        setPickerDelegates()
        setTappedGesture()
        phoneNumber.delegate = self
        username.delegate = self
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        company.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if(!email.text!.isEmpty){
            email.text = ""
            email.removeFloatingLabel()
            email._placeholder = "Email".localize
        }
        
        if(!password.text!.isEmpty){
            password.text = ""
            password.removeFloatingLabel()
            password._placeholder = "Password".localize
        }
        
        if(!confirmPassword.text!.isEmpty){
            confirmPassword.text = ""
            confirmPassword.removeFloatingLabel()
            confirmPassword._placeholder = "Confirm Password".localize
        }
        
        if(!company.text!.isEmpty){
            company.text = ""
            company.removeFloatingLabel()
            company._placeholder = "company".localize
        }
        
        if(!username.text!.isEmpty){
            username.text = ""
            username.removeFloatingLabel()
            username._placeholder = "Username".localize
        }
        
        if(!phoneNumber.text!.isEmpty){
            username.text = ""
            username.removeFloatingLabel()
            username._placeholder = "Mobile Number".localize
        }
        
        
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




