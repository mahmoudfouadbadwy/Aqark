//
//  LoginViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController{
    
    @IBOutlet weak var dontHaveAccount: UILabel!
    @IBOutlet weak var userEmailTextField: CustomTextField!
    @IBOutlet weak var userPasswordTextField: CustomTextField!
    private var loginViewModel : LoginViewModel!
    var dataAccess : LoginDataAccessLayer!
    var profile : ProfileViewController!
    var  firstScreen: FirstScreenViewController!
    var adminView:AdminTabBarController!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        if ProfileNetworking.checkAuthuntication(){
            if !ProfileNetworking.isAdmin()
            {
                gotoProfileView()
            }
            else
            {
                gotoAdminView()
            }

        }
    }
    private func setupView() {
        self.view.backgroundColor = UIColor(rgb: 0xf1faee)
        dontHaveAccount.textColor = UIColor(rgb: 0x457b9d)
        self.setTappedGesture()
        self.navigationItem.title = "Login".localize
    }
    
    private func setupTextFields() {
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
        self.userEmailTextField.setIcon(UIImage(named: "Email")!)
        self.userPasswordTextField.setIcon(UIImage(named: "password")!)
    }
    
    @IBAction func login(_ sender: Any) {
        view.endEditing(true)
        dataAccess = LoginDataAccessLayer()
        loginViewModel = LoginViewModel(dataAccess:dataAccess)
        self.showActivityIndicator()
        loginViewModel.userEmail = userEmailTextField.text
        loginViewModel.userPassword = userPasswordTextField.text
        if(loginViewModel.isValid){
            if(loginViewModel.checkNetworkConnection()){
                loginViewModel.authenticateLogin { [weak self] (result,error) in
                    self?.stopActivityIndicator()
                    if let error = error {
                        self?.showAlert(title: "Login".localize, message: error)
                    }else{
                        if(self!.loginViewModel.isAdminLogged()){
                            self?.gotoAdminView()
                        }else{
                            self?.gotoProfileView()
                        }
                    }
                }
            }else{
                showAlert(title: "Connection".localize, message: "Internet Connection Not Available".localize)
            }
        }else{
            self.stopActivityIndicator()
            showAlert(title: "Login".localize, message: loginViewModel.brokenRules.first!.message)
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        firstScreen = FirstScreenViewController()
        self.navigationController?.pushViewController(firstScreen, animated: true)
    }
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK".localize, style: UIAlertAction.Style.cancel){(okAction) in
            alert.dismiss(animated: true, completion: nil)}
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func gotoProfileView()
    {
        profile = ProfileViewController()
        self.navigationController?.pushViewController(profile, animated: true)
    }
    
    func gotoAdminView(){
        adminView = AdminTabBarController()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(adminView, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if(!userEmailTextField.text!.isEmpty){
            userEmailTextField.text = ""
            userEmailTextField.removeFloatingLabel()
            userEmailTextField._placeholder = "Email".localize
        }
        
        if(!userPasswordTextField.text!.isEmpty){
            userPasswordTextField.text = ""
            userPasswordTextField.removeFloatingLabel()
            userPasswordTextField._placeholder = "Password".localize
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        loginViewModel = nil
        dataAccess = nil
        profile = nil
        firstScreen =  nil
        adminView = nil
    }

}

extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

