//
//  FirstScreenViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    @IBOutlet weak var rolesPicker: UIPickerView!
    var roles : [String] = [String]()
    var userRole : String = "User"
    private var loginViewModel : LoginViewModel!
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.title = "Role"
        self.navigationItem.hidesBackButton = true
        loginViewModel = LoginViewModel()
        if(loginViewModel.checkNetworkConnection()){
            rolesPicker.delegate = self
            rolesPicker.dataSource = self
            roles = ["User","Lawyer","Interior Designer"]
        }else{
            //PlaceHolder image for no internet connection.
        }
        }
    
    @IBAction func submit(_ sender: Any) {
        if(loginViewModel.checkNetworkConnection()){
            let loginView = LoginViewController()
                  loginView.userRole = userRole
            self.navigationController?.pushViewController(loginView, animated: true)
        }else{
            showAlert(title: "Connection", message: "Check your internet connection")
        }
    }
    
    func showAlert(title:String,message:String){
          let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
          let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel){(okAction) in
              alert.dismiss(animated: true, completion: nil)}
          alert.addAction(okAction)
          self.present(alert, animated: true, completion: nil)
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
}
