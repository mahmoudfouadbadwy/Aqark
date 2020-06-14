//
//  AdminNetworking.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 6/13/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import ReachabilitySwift

struct AdminNetworking{
    static func checkNetworkConnection()->Bool
      {
          let connection = Reachability()
          guard let status = connection?.isReachable else{return false}
          return status
      }
}
