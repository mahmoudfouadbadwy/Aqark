//
//  Network.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import ReachabilitySwift

func checkNetworkConnection()->Bool
{
    let connection = Reachability()
    guard let status = connection?.isReachable else{return false}
    return status
}
