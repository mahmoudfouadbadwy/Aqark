//
//  AdminReportsViewModel.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/31/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

struct AdminReportViewModel{
    var reportId:String
    var reportContent:String
    var userId:String
    var agentId:String
    var advertisementId:String
    
    init(report:AdminReport) {
        self.reportId = report.reportId
        self.advertisementId = report.advertisementId
        self.userId = report.userId
        self.agentId = report.agentId
        self.reportContent = report.reportContent
    }
}


class AdminReportsList{
    var adminReportData:AdminReportsData
    var reportsList:[AdminReportViewModel]!
    init(reportData:AdminReportsData) {
        self.adminReportData = reportData
    }
    
    func getAllReports(completion:@escaping([AdminReportViewModel],[String],[String])->Void)
    {
        
        adminReportData.getAdminReports(completion: {
            (reports,users,agents) in
            self.reportsList =  reports.map{report in AdminReportViewModel(report: report)}
             completion(self.reportsList,users,agents)
        })
       
    }
    
    func deleteReport(reportId:String)
    {
       adminReportData.deleteReport(reportId: reportId)
    }
}
