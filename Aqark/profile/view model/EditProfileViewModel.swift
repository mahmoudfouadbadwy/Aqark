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
            if userName.isEmpty == true
            {
                borkenRule.append(EditProfileBrokenRule(brokenType: "userName", message: "enter userName"))
            }
        }else{
            
            if userName.isEmpty == true
            {
                borkenRule.append(EditProfileBrokenRule(brokenType: "userName", message: "enter userName"))
            }
            if country.isEmpty == true
            {
                borkenRule.append(EditProfileBrokenRule(brokenType: "country", message: "enter country"))
            }
            if company.isEmpty == true
            {
                borkenRule.append(EditProfileBrokenRule(brokenType: "company", message: "enter company"))
            }
            if((phoneNumber.isEmpty) || (phoneNumber.isEmpty == false)){
                phoneValidate(value: phoneNumber)
            }
        
            
        }
        
    }
    
    func phoneValidate(value: String){
           
        let PHONE_REGEX = "^[0][1]\\d{9}$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        if (value.isEmpty){
            self.borkenRule.append(EditProfileBrokenRule(brokenType: "phoneNumber", message: "enter phoneNumber"))
        }else{
            if phoneTest.evaluate(with: value) {
            }else{
                self.borkenRule.append(EditProfileBrokenRule(brokenType: "phoneNumber", message: "phoneNumber not valild"))
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
    
    
}
