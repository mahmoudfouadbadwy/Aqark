//
//  AgentViewModel.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import ReachabilitySwift
class AgentAdvertisementViewModel{
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
    init(advertisement:AgentAdvertisement) {
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


class AgentAdvertisementListViewModel{
    var advertisements:[AgentAdvertisementViewModel]! = []
    var advertisementsData:AgentDataAccess!
    init(data:AgentDataAccess) {
        self.advertisementsData = data
    }
    func getAllAdvertisements(agentId:String,completion:@escaping([AgentAdvertisementViewModel])->Void)
    {
        if AgentPropertiesNetworking.checkNetworkConnection(){
            advertisementsData.getAgentAdvertisementsIDs(agentId:agentId,completion: {
                (store) in
                if (store.allAdvertisements.count>0)
                {
                    for advertisement in store.allAdvertisements
                    {
                        self.advertisements.append(AgentAdvertisementViewModel(advertisement: advertisement))
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
    }
    
    func removeObservers()
    {
        if advertisementsData != nil{
             advertisementsData.removeObservers()
        }
        advertisements = nil
        advertisementsData = nil
    }
}


struct AgentPropertiesNetworking
{
    static  func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
}
