//
//  EditUI.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 6/14/20.
//  Copyright © 2020 ITI. All rights reserved.
//
import UIKit
extension EditProfileViewController{
    
    func setupView()
    {
        self.view.backgroundColor = UIColor(rgb: 0xf1faee)
        self.navigationItem.title = "Edit Profile".localize
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        viewForImage.layer.cornerRadius = viewForImage.bounds.height / 2
        indicatorView.isHidden = true
    }
    func setupTextFieldDelegates()
    {
        userNameTxtField.delegate = self
        phoneNumberTxtField.delegate = self
        addressTxtField.delegate = self
        companyTxtField.delegate = self
        experianceTxtField.delegate = self
    }
    
    func setupProfilePic()
    {
        cameraChangeProfilePic.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLibrary)))
        cameraChangeProfilePic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLibrary)))
    }
    
    
    func setupImageTextField()
    {
        userNameTxtField.setIcon(UIImage(named: "profile")!)
        phoneNumberTxtField.setIcon(UIImage(named: "phone")!)
        addressTxtField.setIcon(UIImage(named: "profile_map")!)
        companyTxtField.setIcon(UIImage(named: "company")!)
        experianceTxtField.setIcon(UIImage(named: "experience")!)
    }
    
    func showAlert(title: String , message : String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok".localize, style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
