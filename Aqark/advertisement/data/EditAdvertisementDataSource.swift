//
//  EditAdvertisementDataSource.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/21/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase
class EditAdvertisementDataSource{
    
    
    var dataBaseRef: DatabaseReference!
    var storageRef: StorageReference!
    var advertisementId :String!
    var editAdvertisementModel : EditAdvertisementModel!
   
    init(advertisementId: String) {
        self.dataBaseRef = Database.database().reference()
        self.advertisementId = advertisementId
    }
    
    
   
    
    func fetchAdvertisement(complition:@escaping(EditAdvertisementModel)->()){
        dataBaseRef.child("Advertisements").child(advertisementId).observe(DataEventType.value, with: { (snapshot) in
            if snapshot.exists(){
                let editAdvertisement = snapshot.value as? [String : AnyObject] ?? [:]
                
                self.editAdvertisementModel = EditAdvertisementModel(phone: editAdvertisement["phone"] as? String ,
                                               bathRooms: editAdvertisement["bathRooms"] as? String ,
                                               country: editAdvertisement["country"] as? String ,
                                               bedRooms: editAdvertisement["bedRooms"] as? String ,
                                               AdvertisementType: editAdvertisement["Advertisement Type"] as? String ,
                                               date: editAdvertisement["date"] as? String ,
                                               description: editAdvertisement["description"] as? String ,
                                               price: editAdvertisement["price"] as? String ,
                                               payment: editAdvertisement["payment"] as? String ,
                                               propertyType: editAdvertisement["propertyType"] as? String ,
                                               images: editAdvertisement["images"] as? [String] ,
                                               Address: editAdvertisement["Address"] as? [String:String] ,
                                               size: editAdvertisement["size"] as? String ,
                                               UserId: editAdvertisement["UserId"] as? String,
                                               amenities: editAdvertisement["amenities"] as? [String] )

                complition(self.editAdvertisementModel)
                
                
            }
          
                
        })
    }
    
    
    
    func deleteStorgeImage(urlImages : [String]){
        storageRef = Storage.storage().reference(withPath: "images/\(urlImages[0])")
        storageRef.delete { error in
            if let error = error
            {
                print(error.localizedDescription)
            }
            else
            {
                print("sucess you deleted image ")
            }
        }
    }
    
    func updateAdvertisement(advertisement : AddAdvertisementModel){
        
        
        let userID:String = Auth.auth().currentUser!.uid
        
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
                "UserId" : userID,
                "payment" : advertisement.payment] as [String : Any]
  
        dataBaseRef.child("Advertisements").child(advertisementId).setValue(add)
        
    }
    

}
