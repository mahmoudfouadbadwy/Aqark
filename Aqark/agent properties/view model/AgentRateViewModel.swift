//
//  AgentRateViewModel.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/30/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

class AgentRateViewModel {
    func setRate(rate:Double,agentId:String)->Bool{
        return AgentRate().setUserRating(rate: rate,agentId:agentId)
    }
}
