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
    @IBOutlet private weak var phoneNumber: UITextField!
    @IBOutlet private weak var username: UITextField!
    @IBOutlet private weak var email: UITextField!
    @IBOutlet private weak var password: UITextField!
    @IBOutlet private weak var confirmPassword: UITextField!
    @IBOutlet private weak var company: UITextField!
    @IBOutlet private weak var countries: UIPickerView!
    var role:String = "lawyer"
    private var accountViewModel:AccountViewModel!
    private let networkIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private var countriesPicker:[String] = Countries().countries
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.email.setIcon(UIImage(named: "signup_email")!)
        self.password.setIcon(UIImage(named: "signup_password")!)
        self.confirmPassword.setIcon(UIImage(named: "signup_password")!)
        self.username.setIcon(UIImage(named: "signup_username")!)
        self.phoneNumber.setIcon(UIImage(named: "signup_phone")!)
        self.company.setIcon(UIImage(named: "signup_company")!)
  }
  func showUserView()
  {
        self.phoneNumber.isHidden = true
        self.countries.isHidden = true
        self.company.isHidden = true
   }
}

//MARK: - create Account
extension SignUpView{
    func createUserAccount(email:String,password:String,confirm:String,username:String)
    {
        accountViewModel = AccountViewModel(email: email, password: password, confirmPassword: confirm, username: username)
        checkValidation()
    }
    func createServiceAccount(email:String,password:String,confirm:String,username:String,
                              phone:String,country:String,company:String){
        accountViewModel = AccountViewModel(email: email, password: password, confirmPassword: confirm, username: username, phone: phone, country: country, company: company,role:role)
        checkValidation()
    }
    
    func checkValidation()
    {
        if (accountViewModel.isValid)
        {
            showIndicator()
            accountViewModel.performCreation(dataAccess: DataAccess(),completion: {
                (result) in
                self.stopIndicator()
                self.showAlert(with: result)
            })
        }
        else
        {
            self.showAlert(with: accountViewModel.brokenRules[0].message)
        }
    }
}

//MARK: - ALertView
extension SignUpView{
    func showAlert(with message:String){
        let alert:UIAlertController = UIAlertController(title: "Validation Message", message:message , preferredStyle: .alert)
        let ok:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UIViewIndicator
extension SignUpView{
    func showIndicator()
    {
        networkIndicator.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        networkIndicator.center = view.center
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
    }
    
    func stopIndicator() {
        networkIndicator.stopAnimating()
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
    func setIcon(_ image: UIImage) {
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
