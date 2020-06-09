//
//  AdminDeleteAdvertisement&Logout.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase

extension AdminDataAccess{
    
    func deleteAdvertisment(adminAdvertisement:AdminAdvertisementViewModel,completionForDeleteAdvertisement:@escaping(_ deleted:Bool)->Void){
        deleteFromUsersAds(by: adminAdvertisement.advertisementUserId, and: adminAdvertisement.advertisementId){(deleted)in
            if(deleted){
                self.deleteFromAdvertisements(by: adminAdvertisement.advertisementId)
                completionForDeleteAdvertisement(true)
            }else{
                completionForDeleteAdvertisement(false)
            }
        }
    }
    
    private func deleteFromUsersAds(by userID : String,and advertisementID : String,completion:@escaping(_ deleted:Bool)->Void)
    {
        ref.child("Users_Ads").child(userID).child("advertisements").observeSingleEvent(of: .value) { (data) in
            if (data.value is NSNull){
                completion(false)
            }else{
                var advertisements = data.value as! [String]
                advertisements.removeAll{$0 == advertisementID}
                self.ref.child("Users_Ads").child(userID).child("advertisements").setValue(advertisements)
                completion(true)
            }
        }
    }
    
    private func deleteFromAdvertisements(by advertisementID:String)
    {
        ref.child("Advertisements").child(advertisementID).removeValue()
    }
}
