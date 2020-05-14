//
//  LoginViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{

    @IBOutlet weak var userEmailTextField: CustomTextField!
    @IBOutlet weak var userPasswordTextField: CustomTextField!
    private var loginViewModel : LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
        loginViewModel = LoginViewModel()
    }


    @IBAction func login(_ sender: Any) {
        loginViewModel.userEmail = userEmailTextField.text
        loginViewModel.userPassword = userPasswordTextField.text
        if(loginViewModel.isValid){
            loginViewModel.authenticateLogin()
            showAlert(message: "Valid Login")
        }else{
            showAlert(message: loginViewModel.brokenRules.first!.message)
            print(loginViewModel.brokenRules)
        }
    }
    
    func showAlert(message:String){
        let alert = UIAlertController(title: "Invalid Login", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel){(okAction) in
            alert.dismiss(animated: true, completion: nil)}
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

