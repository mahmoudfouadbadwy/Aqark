//
//  ProfileAdvertisements.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase
extension ProfileDataAccess{
    
    func getProfileAdvertisementsIDs(completion:@escaping(AdvertismentsStore)->Void)
    {
        let ref = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else {return}
        ref.child("Users_Ads").child(userID).child("advertisements").observeSingleEvent(of: .value) { (snapshot) in
            if (snapshot.exists())
            {
                let advertisementsIds:[String] = snapshot.value as! [String]
                self.getAllAdvertisements(by: advertisementsIds,completion: {
                    (store) in
                    completion(store)
                })
            }
        }
    }
    
    func getAllAdvertisements(by arrOfIDs:[String],completion:@escaping(AdvertismentsStore)->Void)
    {
        var advertisementsStore:AdvertismentsStore = AdvertismentsStore()
        for id in arrOfIDs
        {
            let ref = Database.database().reference()
            ref.child("Advertisements").child(id).observeSingleEvent(of: .value) { (snapshot) in
                if (snapshot.exists())
                {
                    let value  = snapshot.value as? NSDictionary
                    let propertyType = value?["propertyType"] as? String ?? ""
                    let price = value?["price"] as? String ?? ""
                    let address = value?["Address"] as? NSDictionary
                    let location = address?["location"] as? String ?? ""
                    let bedrooms = value?["bedRooms"] as? String ?? ""
                    let bathrooms = value?["bathRooms"] as? String ?? ""
                    let size = value?["size"] as? String ?? ""
                    
                    let advertisement:ProfileAdvertisement = ProfileAdvertisement(propertyType:propertyType,price:price,address:location,bed:bedrooms,bathroom:bathrooms,propertySize:size)
                    advertisementsStore.addAdvertisement(advertisement)
                    if advertisementsStore.allAdvertisements.count == arrOfIDs.count{
                        completion(advertisementsStore)
                    }
                   
                }
            }
        }
        
    }
    
}
