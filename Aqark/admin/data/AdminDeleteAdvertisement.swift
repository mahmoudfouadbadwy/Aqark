//
//  AdminDeleteAdvertisement&Logout.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase

extension AdminDataAccessLayer{
    func deleteAdvertisment(adminAdvertisement:AdminAdvertisementViewModel){
        deleteFromUsersAds(by: adminAdvertisement.advertisementUserId, and: adminAdvertisement.advertisementId)
        deleteFromAdvertisements(by: adminAdvertisement.advertisementId)
    }
    
    private func deleteFromUsersAds(by userID : String,and advertisementID : String)
    {
        ref.child("Users_Ads").child(userID).child("advertisements").observeSingleEvent(of: .value) { (data) in
            var advertisements = data.value as! [String]
            advertisements.removeAll{$0 == advertisementID}
            self.ref.child("Users_Ads").child(userID).child("advertisements").setValue(advertisements)
        }
    }
    
    private func deleteFromAdvertisements(by advertisementID:String)
    {
        ref.child("Advertisements").child(advertisementID).removeValue()
    }
}
