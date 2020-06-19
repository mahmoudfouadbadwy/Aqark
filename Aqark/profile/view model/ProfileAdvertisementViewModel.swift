//
//  ProfileAdvertisementViewModel.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
class ProfileAdvertisementViewModel{
    var propertyType:String!
    var price:Double!
    var address:String!
    var bedroom:String!
    var bathroom:String!
    var size:String!
    var image:String!
    var payment:String!
    var advertisementType:String!
    var advertisementId:String!
    init(advertisement:ProfileAdvertisement) {
        self.propertyType = advertisement.propertyType
        self.price = advertisement.price
        self.address = advertisement.address
        self.bedroom = advertisement.bed
        self.bathroom = advertisement.bathroom
        self.size = advertisement.propertySize
        self.image = advertisement.propertyImage
        self.payment = advertisement.paymentType
        self.advertisementType = advertisement.advertisementType
        self.advertisementId = advertisement.advertisementId
    }
}


class ProfileAdvertisementListViewModel{
    var advertisements:[ProfileAdvertisementViewModel]! = []
    var advertisementsData:ProfileDataAccess!
    init(data:ProfileDataAccess) {
        self.advertisementsData = data
    }
    func getAllAdvertisements(completion:@escaping([ProfileAdvertisementViewModel])->Void)
    {
        advertisementsData.getProfileAdvertisementsIDs(completion: {
            (store) in
            if (store.allAdvertisements.count>0)
            {
                for advertisement in store.allAdvertisements
                {

                    self.advertisements.append(ProfileAdvertisementViewModel(advertisement: advertisement))
                    if self.advertisements.count == store.allAdvertisements.count
                    {
                        completion((self.advertisements))
                    }
                }
            }
            else
            {
                completion([])
            }
            
        })
       
    }
    
    func removeProfileAdvertisementsObservers()
    {
         advertisementsData.removeProfileAdvertisementsObservers()
         advertisementsData = nil
         advertisements = nil
    }
}

class AdvertisementDelete
{
    var data:ProfileDataAccess!
    init(dataAcees:ProfileDataAccess) {
        self.data = dataAcees
    }
    func deleteAdvertisement(id:String)
    {
        data.deleteAdvertisment(id: id)
    }
    
    func removeDeleteObserver()
    {
        data.removeDeleteObservers()
        data = nil
    }
}
