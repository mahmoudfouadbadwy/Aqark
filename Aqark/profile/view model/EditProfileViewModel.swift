//
//  EditProfileViewModel.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

class EditProfileViewModel : EditProfileProtocol
{
    var imageView : Any
    var userName : String
    var phoneNumber:  String
    var country : String
    var address : String
    var company : String
    var experiance : String
    var role : String
    var editProfileDataSource : EditProfileDataSource = EditProfileDataSource()
    var borkenRule: [EditProfileBrokenRule] = [EditProfileBrokenRule]()
    
    var isValid: Bool{
        get{
            self.MakeValidation()
            return self.borkenRule.count == 0 ? true : false
        }
    }
    
    init(imageView : Any , userName : String , phoneNumber : String , country : String , address : String , company : String , experiance : String , role : String)
    {
        self.imageView = imageView
        self.userName = userName
        self.phoneNumber = phoneNumber
        self.country = country
        self.address = address
        self.company = company
        self.experiance = experiance
        self.role = role
    }
    
    func MakeValidation(){
        
        if role == "user"
        {
            if (userName.isEmpty) || ( userName.isEmpty == false)
            {
                userNameValidate(value: userName)
            }
        }else{
            
            if (userName.isEmpty) || ( userName.isEmpty == false)
            {
                userNameValidate(value: userName)
            }
            if country.isEmpty == true
            {
                borkenRule.append(EditProfileBrokenRule(brokenType: "country".localize, message: "Country must be provided.".localize))
            }
            if company.isEmpty == true
            {
                borkenRule.append(EditProfileBrokenRule(brokenType: "Company".localize, message: "Company must be provided.".localize))
            }
            if((phoneNumber.isEmpty) || (phoneNumber.isEmpty == false)){
                phoneValidate(value: phoneNumber)
            }
        
            
        }
        
    }
    
    func userNameValidate(value : String) {
        
        let USERNAME_REGEX = "^(?=.{6,20}$)(?![0-9._])(?!.*[_.]{2})[a-zA-Z0-9._\\u0621-\\u064A ]+(?<![_.])$";
        
        let userNameTest = NSPredicate(format: "SELF MATCHES %@", USERNAME_REGEX)
        
        if (value.isEmpty){
            self.borkenRule.append(EditProfileBrokenRule(brokenType: "Username".localize, message: "Username must be provided.".localize))
        }else{
            if !(userNameTest.evaluate(with: value)) {
                self.borkenRule.append(EditProfileBrokenRule(brokenType: "Username".localize, message: "Username must start of letter and be between 6 and 20 characters.".localize))
            }
        }
    }
    
    func phoneValidate(value: String){
           
        let PHONE_REGEX = "^[0][1]\\d{9}$".localize
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        if (value.isEmpty){
            self.borkenRule.append(EditProfileBrokenRule(brokenType: "Mobile Number".localize, message: "enter phoneNumber".localize))
        }else{
            if phoneTest.evaluate(with: value) {
            }else{
                self.borkenRule.append(EditProfileBrokenRule(brokenType: "Mobile Number".localize, message: "phoneNumber not valild".localize))
            }
        }
    }
    
    func updateProfileData()
    {
        editProfileDataSource.prepareData(editProfile: EditProfileModel(username: userName,country: country,address: address,company: company,phone: phoneNumber,experience: experiance))
        
        if imageView is Data{
            editProfileDataSource.imageData = (imageView as! Data)
            editProfileDataSource.uploadeImageToStorage()
        }else{
            
            editProfileDataSource.urlImage = (imageView as? String ?? "")
            editProfileDataSource.uploadProfileAfterEdit()

        }
    }
    
    func removeAllEditProfileRef(){
        editProfileDataSource.removeAllEditProfileRef()
    }
    
    
}
