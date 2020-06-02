//
//  ReportData.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase

class ReportData{
    var dataBaseRef: DatabaseReference!
    var newReport : [String : Any] = [String : Any]()
     var reportModel: ReportModel!
    var idAutoGenerator :String!
    
    func addReport(reportModel : ReportModel,completion:@escaping(_ result: Bool?)->Void){
        self.dataBaseRef = Database.database().reference()
        idAutoGenerator = dataBaseRef.childByAutoId().key!
        newReport = [
        "ReportText": reportModel.reportText,
        "AdvertisementId": reportModel.advertisementId,
        "AgentId": reportModel.agentId,
        "UserId": reportModel.userId
    ]
        
     self.dataBaseRef.child("Reports").child(idAutoGenerator!).setValue(newReport)
        completion(true)
    
    }
    
}
 
