//
//  AgentRateViewModel.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/30/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase
class AgentRateViewModel {
    func setRate(rate:Double,agentId:String)->Bool{
        return AgentRate().setUserRating(rate: rate,agentId:agentId)
    }
    
    static func checkUser(userId:String)->Bool
    {
        
        guard let user = Auth.auth().currentUser else {return false}
        if user.uid.elementsEqual(userId)
        {
            
            return false
        }
        return true
    }
    
}
