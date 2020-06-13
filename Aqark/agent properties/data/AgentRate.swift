//
//  AgentRate.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/30/20.
//  Copyright © 2020 ITI. All rights reserved.
//


import Firebase
import ReachabilitySwift
class AgentRate{
    var ref:DatabaseReference! = Database.database().reference()
    func setUserRating(rate:Double,agentId:String)->Bool
    {
        if checkNetworkConnection(){
           
            let userId = getUserId()
            if userId != ""{
                ref.child("Users").child(agentId).child("rate").child(userId).setValue(rate)
                return true
            }
        }
        
       return false
    }

    private func getUserId()->String
    {
        guard let user = Auth.auth().currentUser else {return ""}
        return user.uid
    }
    private func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
    
    func removeObject()
    {
      ref = nil
    }
    
}
