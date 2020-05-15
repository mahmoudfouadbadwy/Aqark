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
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    var userRole : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userRole)
        loginViewModel = LoginViewModel()
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
    }
      
    @IBAction func login(_ sender: Any) {
        view.endEditing(true)
        loginActivityIndicator.startAnimating()
        loginViewModel.userEmail = userEmailTextField.text
        loginViewModel.userPassword = userPasswordTextField.text
        if(loginViewModel.isValid){
            if(loginViewModel.checkNetworkConnection()){
                loginViewModel.authenticateLogin { (result,error) in
                    if let error = error {
                        self.loginActivityIndicator.stopAnimating()
                        self.showAlert(title: "Logged", message: error)
                        //TODO: move to account details view
                    }else{
                        self.loginActivityIndicator.stopAnimating()
                        self.showAlert(title:"Invalid Login", message: result!)
                    }
                }
            }else{
                showAlert(title: "Connection", message: "Check yout internet connection")
            }
        }else{
            loginActivityIndicator.stopAnimating()
            showAlert(title: "Invalid Login", message: loginViewModel.brokenRules.first!.message)
            print(loginViewModel.brokenRules)
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        //Transfer user role to sign up view
    }
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
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

