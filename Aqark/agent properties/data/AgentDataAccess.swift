//
//  AgentDataAccess.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//


import Foundation
import Firebase
class AgentDataAccess{
    
    func getAgentAdvertisementsIDs(agentId:String,completion:@escaping(AgentAdvertismentsStore)->Void)
    {
        let ref = Database.database().reference()
        ref.child("Users_Ads").child(agentId).child("advertisements").observe(.value) { (snapshot) in
            if (snapshot.exists())
            {
                let advertisementsIds:[String] = snapshot.value as! [String]
                self.getAllAdvertisements(by: advertisementsIds,completion: {
                    (store) in
                    completion(store)
                })
            }
            else
            {
                
                completion(AgentAdvertismentsStore())
            }
        }
    }
    
    func getAllAdvertisements(by arrOfIDs:[String],completion:@escaping(AgentAdvertismentsStore)->Void)
    {
        var advertisementsStore:AgentAdvertismentsStore = AgentAdvertismentsStore()
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
                    let images = value?["images"] as? [String] ?? ["NoImage"]
                    let payment = value?["payment"] as? String ?? ""
                    let advertisementType = value?["AdvertisementType"] as? String ?? ""
                    let advertisement:AgentAdvertisement = AgentAdvertisement(propertyType:propertyType,price:Double(price) ?? 0.0,address:location,bed:bedrooms,bathroom:bathrooms,propertySize:size, propertyImage: images[0], paymentType: payment, advertisementType: advertisementType, advertisementId: id)
                    advertisementsStore.addAdvertisement(advertisement)
                    if advertisementsStore.allAdvertisements.count == arrOfIDs.count{
                        completion(advertisementsStore)
                    }
                    
                }
            }
        }
        
}
}
