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
    
    
    var dataBaseRef: DatabaseReference?
    var storageRef: StorageReference?
    var advertisementId :String!
    var editAdvertisementModel : EditAdvertisementModel!
    var images:[String] = [String]()
    var urlImages : [String] = [String]()
    var dataImages : [Data] = [Data]()
    var index = 0
    
    init(advertisementId: String) {
        self.dataBaseRef = Database.database().reference()
        self.advertisementId = advertisementId
    }
    //MARK:- fetch advertisemnt
    func fetchAdvertisement(complition:@escaping(EditAdvertisementModel)->()){
        dataBaseRef?.child("Advertisements").child(advertisementId).observe(DataEventType.value, with: { (snapshot) in
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
    
    //MARK: - delete Strorge Image
    func deleteStorgeImage(urlImages : [String]){
        for i in urlImages{
            storageRef = Storage.storage().reference(withPath: "images/\(i)")
            storageRef?.delete { error in
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
    }
    
    //MARK: - update or edit data
    func updateAdvertisement(advertisement : EditAdvertisementModel){
        let userID:String = Auth.auth().currentUser!.uid
        let add : [String : Any] = [ "propertyType" : advertisement.propertyType ?? "",
                                     "Advertisement Type" : advertisement.AdvertisementType ?? "",
                                     "price" : advertisement.price ?? "",
                                     "bedRooms" : advertisement.bedRooms ?? "",
                                     "bathRooms" : advertisement.bathRooms ?? "",
                                     "size" : advertisement.size ?? "",
                                     "phone" : advertisement.phone ?? "",
                                     "country": advertisement.country ?? "",
                                     "description": advertisement.description ?? "",
                                     "date" : advertisement.date ?? "",
                                     "Address" : advertisement.Address ?? "",
                                     "amenities" : advertisement.amenities ?? "",
                                     "UserId" : userID ,
                                     "payment" : advertisement.payment ?? "",
                                     "images" : images + urlImages]
        
        dataBaseRef?.child("Advertisements").child(advertisementId).updateChildValues(add)
        NotificationCenter.default.post(name: .indicator, object: nil)
    }
    
    func uploadeImageToStorage(advertisement: EditAdvertisementModel){
        let meta = StorageMetadata.init()
        meta.contentType = "image/jpeg"
        let randomUUID = UUID.init().uuidString
        storageRef = Storage.storage().reference(withPath: "images/\(randomUUID).jpg")
        
        self.storageRef?.putData(dataImages[index], metadata: meta) {[weak self] (metadata, error) in
            self!.getImageUrl {[weak self] (value, myError) in
                if myError == nil{
                    self!.images.append(value!)
                    if self!.dataImages.count != self!.images.count
                    {
                        self!.index = self!.index+1
                        self?.uploadeImageToStorage(advertisement: advertisement)
                    }else{
                        self!.updateAdvertisement(advertisement: advertisement)
                    }
                }
            }
        }
    }
    func getImageUrl(comoletionValue : @escaping (String? , Error?)->Void){
        self.storageRef?.downloadURL {(url, error) in
            guard let url = url else {return}
            comoletionValue("\(url)", error)
        }
    }
    
    func removeAllEditDataRefrance(){
        dataBaseRef = nil
        storageRef = nil
    }
    
}
