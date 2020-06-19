//
//  MocReportData.swift
//  AqarkTests
//
//  Created by Mostafa Samir on 6/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
@testable import Aqark

class MocReportData {
    
    var arrOfReviews: [Any] = []
    func addReport(reportModel : ReportModel,completion:@escaping(_ result: Bool?)->Void){
        
        let newReport = [
            "ReportText": reportModel.reportText,
            "AdvertisementId": reportModel.advertisementId,
            "AgentId": reportModel.agentId,
            "UserId": reportModel.userId
        ]
        arrOfReviews.append(newReport)
        print(arrOfReviews)
        completion(true)
    }
}
