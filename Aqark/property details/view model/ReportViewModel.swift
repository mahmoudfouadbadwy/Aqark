//
//  ReportViewModel.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase
class ReportViewModel{
       var reportText: String!
       var advertisementId: String!
//       var userAuth : String!
       var agentId: String!
       var dataAccess : ReportData!
       var reportModel: ReportModel!
       var userAuth  = Auth.auth().currentUser!.uid as String
    
    init(dataAccess : ReportData) {
          self.dataAccess = dataAccess
      }
    func setReportData(reportModel : ReportModel){
        ReportData().addReport(reportModel: reportModel)
        
    }
    
}
