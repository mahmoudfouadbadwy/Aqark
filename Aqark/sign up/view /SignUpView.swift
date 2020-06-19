//
//  SignUpView.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import GooglePlaces
//MARK:- Life cycle and Properties
class SignUpView: UIViewController  {
    @IBOutlet  weak var phoneNumber: CustomTextField!
    @IBOutlet  weak var username: CustomTextField!
    @IBOutlet  weak var email: CustomTextField!
    @IBOutlet  weak var password: CustomTextField!
    @IBOutlet  weak var confirmPassword: CustomTextField!
    @IBOutlet  weak var company: CustomTextField!
    @IBOutlet weak var address: CustomTextField!
    @IBOutlet weak var governmantHint: UILabel!
    @IBOutlet weak var haveAccount: UILabel!
    var signUpDataAccess: SignUpDataAccess!
    var role:String = "user"
    var userViewModel:AccountViewModel!
    var serviceViewModel:AccountViewModel!
    var autocompletecontroller : GMSAutocompleteViewController!
    var filter : GMSAutocompleteFilter!
    var profileView:ProfileViewController!
    var alert:UIAlertController!
    var ok:UIAlertAction!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sign Up".localize
        self.view.backgroundColor = UIColor(rgb: 0xf1faee)
        setupViews(as: role)
        setIcons()
        setTextFieldsDelegate()
        setTappedGesture()
        setupObjects()
    }
    private func setupObjects()
    {
        autocompletecontroller = GMSAutocompleteViewController()
        autocompletecontroller?.delegate = self
        filter = GMSAutocompleteFilter()
    }

    override func viewDidDisappear(_ animated: Bool) {
        
        if(!email.text!.isEmpty){
          //  email.text = ""
            email.removeFloatingLabel()
            email._placeholder = "Email".localize
        }
        
        if(!password.text!.isEmpty){
         //   password.text = ""
            password.removeFloatingLabel()
            password._placeholder = "Password".localize
        }
        
        if(!confirmPassword.text!.isEmpty){
         //   confirmPassword.text = ""
            confirmPassword.removeFloatingLabel()
            confirmPassword._placeholder = "Confirm Password".localize
        }
        
        if(!company.text!.isEmpty){
          //  company.text = ""
            company.removeFloatingLabel()
            company._placeholder = "company".localize
        }
        
        if(!username.text!.isEmpty){
           // username.text = ""
            username.removeFloatingLabel()
            username._placeholder = "Username".localize
        }
        
        if(!phoneNumber.text!.isEmpty){
          //  username.text = ""
            username.removeFloatingLabel()
            username._placeholder = "Mobile Number".localize
        }
        if userViewModel != nil {

            userViewModel = nil
        }
        if serviceViewModel != nil{
            serviceViewModel = nil
        }
        if signUpDataAccess != nil {

            signUpDataAccess = nil
        }
    }
    
    @IBAction func addressAutocomplete(_ sender: Any) {
        filter?.type = .address //suitable filter type
        filter?.country = "eg"  //appropriate country code
        autocompletecontroller?.autocompleteFilter = filter
        present(autocompletecontroller!, animated: true, completion: nil)

    }
    
    @IBAction func createAccount(_ sender: Any) {
        guard let email = email.text ,
            let password = password.text,
            let confirm = confirmPassword.text,
            let username = username.text,
            let phone = phoneNumber.text,
            let company = company.text,
            let address = address.text
            else { return }
        switch self.role.lowercased() {
        case "user":
            createUserAccount(email: email, password:password,confirm: confirm,username:username)
        default:createServiceAccount(email: email, password: password, confirm: confirm, username: username, phone: phone, country: address, company: company)
        }
    }
    @IBAction func login(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    deinit {
        userViewModel = nil
        serviceViewModel = nil
        signUpDataAccess = nil
        autocompletecontroller  = nil
        filter  = nil
        profileView = nil
        alert = nil
        ok = nil
    }
}




