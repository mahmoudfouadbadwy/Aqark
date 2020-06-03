//
//  EditProfileDataSource.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase
class EditProfileDataSource
{
    
    var dataBaseRef: DatabaseReference!
    var storageRef: StorageReference!
    var userID :String!
    var imageData : Data!
    var urlImage :String = ""
    var post : [String : Any]!
    
    init() {
        self.dataBaseRef = Database.database().reference()
        userID = Auth.auth().currentUser?.uid
    }
    func prepareData(editProfile : EditProfileModel){
        post = ["company": editProfile.company,
                "country": editProfile.country,
                "phone": editProfile.phone,
                "username": editProfile.username,
                "experience" : editProfile.experience ?? "",
                "address":editProfile.address ?? ""]
    }
    func uploadProfileAfterEdit(){
        post.updateValue(urlImage, forKey: "picture")
        dataBaseRef.child("Users").child(userID).updateChildValues(post)
        NotificationCenter.default.post(name: .indicator, object: nil)
    }
    
    func uploadeImageToStorage(){
        let meta = StorageMetadata.init()
        meta.contentType = "image/jpeg"
        let randomUUID = UUID.init().uuidString
        storageRef = Storage.storage().reference(withPath: "images/\(randomUUID).jpg")
        self.storageRef.putData(imageData , metadata: meta) {[weak self] (metadata, error) in
            self!.getImageUrl {[weak self] (value, myError) in
                if myError == nil
                {
                    self!.urlImage = value!
                    self!.uploadProfileAfterEdit()
                }
            }
        }
    }
    func getImageUrl(comoletionValue : @escaping (String? , Error?)->Void){
        self.storageRef.downloadURL {(url, error) in
            guard let url = url else {return}
            comoletionValue("\(url)", error)
        }
    }
    
    
}
