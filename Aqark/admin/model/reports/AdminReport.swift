//
//  AdminReport.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/31/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

struct AdminReport{
   var reportId:String
   var reportContent:String
   var userId:String
   var agentId:String
   var advertisementId:String
}

struct AdminReportsStore{
    var reports:[AdminReport]
    mutating func addReport(report:AdminReport)
    {
        reports.append(report)
    }
}
