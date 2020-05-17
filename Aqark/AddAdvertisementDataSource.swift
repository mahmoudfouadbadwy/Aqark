//
//  AddAdvertisementDataSource.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/14/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation


import Firebase

class AddAdvertisementDataSource{
    
    var dataBaseRef: DatabaseReference!
    var storageRef: StorageReference!
    var taskPerformace:StorageUploadTask!
    var advertisement: AddAdvertisementModel!
    weak var addAdvertisementViewModel : AddAdvertisementViewModel!
    
    
    var images : [String] = [String]()
    
    
    init(advertisement: AddAdvertisementModel) {
        self.advertisement = advertisement
        self.dataBaseRef = Database.database().reference().child("Advertisements").childByAutoId()
        self.uploadAllData()
    }

    
    func addAdvertisementInFirebase(){
        let meta = StorageMetadata.init()
        meta.contentType = "image/jpeg"
        
        for i in advertisement.images{
            
            let randomUUID = UUID.init().uuidString
            storageRef = Storage.storage().reference(withPath: "images/\(randomUUID).jpg")
            self.taskPerformace = self.storageRef.putData(i, metadata: meta) {[weak self] (metadata, error) in
                if let error = error {print(error.localizedDescription) ; return}
                self!.findImageUrl()
            }
        }
    }
    
    func findImageUrl(){
        self.storageRef.downloadURL {[weak self] (url, error) in
            guard let url = url else {return}
            self!.images.append("\(url)")
            self!.uploadImages(url : url)
        }
    }
    
    
    
    func uploadImages(url :URL)  {
        
        self.dataBaseRef.child("images").setValue(images)
        
        if(images.count == advertisement.images.count)
        {
            // indicator stop her!!
            
          
        }
    
    }
    
    func uploadAllData(){
        
        //let userID = Auth.auth().currentUser?.uid
        
        let address = ["location": advertisement.location,
                       "latitude":advertisement.latitude,
                       "longitude": advertisement.longitude]

        let add = [ "propertyType": advertisement.propertyType,
                    "Advertisement Type": advertisement.advertisementType,
                    "price" : advertisement.price,
                    "bedRooms" : advertisement.bedrooms,
                    "bathRooms" : advertisement.bathroom,
                    "size" : advertisement.size,
                    "phone" : advertisement.phone,
                    "country": advertisement.country,
                    "description": advertisement.description,
                    "date" : advertisement.date,
                    "Address" : address,
                    "amenities" : advertisement.aminities,
                    "UserId" : "12345678" ] as [String : Any]
        

        dataBaseRef.setValue(add)
        self.addAdvertisementInFirebase()
    }
    
}
