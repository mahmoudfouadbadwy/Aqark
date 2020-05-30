//
//  ReportExtension.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension PropertyDetailView {
    
    func showReportActionSheet(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Posting Inappropriate things", style: .default , handler:{ (UIAlertAction)in
            self.inappropriateThings = "Posting Inappropriate things"
            self.reportAdvertisement(report: self.inappropriateThings)
        }))
        
        alert.addAction(UIAlertAction(title: "Fake Data", style: .default , handler:{ (UIAlertAction)in
            self.fakeData = "Fake Data"
            self.reportAdvertisement(report: self.fakeData)
        }))
        
        alert.addAction(UIAlertAction(title: "Fake Number", style: .default , handler:{ (UIAlertAction)in
            self.fakeNumber = "Fake Number"
            self.reportAdvertisement(report: self.fakeNumber)
        }))
        
        alert.addAction(UIAlertAction(title: "Deceitful Person", style: .default , handler:{ (UIAlertAction)in
            self.deceitfulPerson = "Deceitful Person"
            self.reportAdvertisement(report: self.deceitfulPerson)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        self.present(alert, animated: true, completion: {
        })
    }
    func reportAdvertisement(report : String){
        self.advertisementReportViewModel.setReportData(reportContent : report,advertisementId: self.advertisementId,agentId: advertisementDetails.userID, completionForSetReportData: { result in
            if (result!){
                self.showAlert(title: "Report have been sent")
                
            }
        })
    }

    func showAlert(title : String){
        let alert = UIAlertController(title: "Report", message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction)in
             alert.dismiss(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func preformReport(){
        self.reportData = ReportData()
        self.advertisementReportViewModel = ReportViewModel(dataAccess: reportData)
        if advertisementReportViewModel.checkUserAuth(){
            showReportActionSheet()
        }else{
            self.showAlert(title: "Please Login To Report This Advertisement")
        }
    }
}
