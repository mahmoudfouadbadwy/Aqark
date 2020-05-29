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
     
       var dataAccess : ReportData!
       var reportModel: ReportModel!
 
    init(dataAccess : ReportData) {
          self.dataAccess = dataAccess
      }
    func setReportData(reportContent : String, advertisementId : String,agentId : String,completionForSetReportData:@escaping(_ result: Bool?)->Void){
        reportModel = ReportModel(reportText: reportContent, advertisementId: advertisementId, userId: self.getUserId() , agentId: agentId)
        dataAccess.addReport(reportModel: reportModel, completion: { result  in
            completionForSetReportData(result)
        })
    }
    
    func getUserId()-> String{
        if let user = Auth.auth().currentUser{
            return user.uid
        }
       return ""
    }
    
    func checkUserAuth()-> Bool{
        if Auth.auth().currentUser != nil {
            return true
        }else{
            return false
        }
    }
}
