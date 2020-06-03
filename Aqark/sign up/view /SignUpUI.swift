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
        default: print("service")
        }
    }
    
    func setIcons()
    {
        self.email.setSignUPIcons(UIImage(named: "signup_email")!)
        self.password.setSignUPIcons(UIImage(named: "signup_password")!)
        self.confirmPassword.setSignUPIcons(UIImage(named: "signup_password")!)
        self.username.setSignUPIcons(UIImage(named: "signup_username")!)
        self.phoneNumber.setSignUPIcons(UIImage(named: "signup_phone")!)
        self.company.setSignUPIcons(UIImage(named: "signup_company")!)
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

//MARK: - UITextField
extension UITextField {
    func setSignUPIcons(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
