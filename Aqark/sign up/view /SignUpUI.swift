//
//  SignUpUI.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/19/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
//MARK: - setup views
extension SignUpView{
    func setupViews(as role:String)
    {
        switch (self.role.lowercased())
        {
        case "user": showUserView()
        default: print("")
        }
    }
    
   func setIcons()
    {
         self.username.setIcon(UIImage(named: "user")!)
         self.email.setIcon(UIImage(named: "Email")!)
         self.password.setIcon(UIImage(named: "password")!)
         self.confirmPassword.setIcon(UIImage(named: "password")!)
         self.phoneNumber.setIcon(UIImage(named: "phone")!)
         self.company.setIcon(UIImage(named: "company")!)
    
    }
    func showUserView()
    {
        self.phoneNumber.isHidden = true
        self.countries.isHidden = true
        self.company.isHidden = true
    }
}

//MARK: - Picker view
extension SignUpView:UIPickerViewDataSource,UIPickerViewDelegate{
    func setPickerDelegates()
    {
        countries.dataSource = self
        countries.delegate = self
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countriesPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countriesPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: countriesPicker[row], attributes: [NSAttributedString.Key.foregroundColor:UIColor(rgb: 0x457b9d)])
    }
}

//MARK: - TextFiled Delegate
extension SignUpView:UITextFieldDelegate{
    func setTextFieldsDelegate()
    {
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        username.delegate = self
        phoneNumber.delegate = self
        company.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setTappedGesture()
    {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
}
