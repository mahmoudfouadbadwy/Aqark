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
        alert.addAction(UIAlertAction(title: "Posting Inappropriate things".localize, style: .default , handler:{ (UIAlertAction)in
            self.reportAdvertisement(report: "Posting Inappropriate things")
        }))
        
        alert.addAction(UIAlertAction(title: "Fake Data".localize, style: .default , handler:{ (UIAlertAction)in
            self.reportAdvertisement(report: "Fake Data")
        }))
        
        alert.addAction(UIAlertAction(title: "Fake Number".localize, style: .default , handler:{ (UIAlertAction)in
            self.reportAdvertisement(report:  "Fake Number")
        }))
        
        alert.addAction(UIAlertAction(title: "Deceitful Person".localize, style: .default , handler:{ (UIAlertAction)in
            self.reportAdvertisement(report: "Deceitful Person")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel".localize, style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        self.present(alert, animated: true, completion: {
        })
    }
    func reportAdvertisement(report : String){
        self.advertisementReportViewModel.setReportData(reportContent : report,advertisementId: self.advertisementId,agentId: advertisementDetails.userID, completionForSetReportData: {[weak self] result in
            if (result!){
                self?.showAlert(title: "Report".localize, message: "Report have been sent".localize)
                
            }
        })
    }

    func showAlert(title : String , message : String){

        let alert = UIAlertController(title: title , message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok".localize, style: .default, handler:{[weak alert] (UIAlertAction)in
            alert?.dismiss(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func preformReport(){
        self.reportData = ReportData()
        self.advertisementReportViewModel = ReportViewModel(dataAccess: reportData)
        if propertyViewModel.checkAdvertisementOwner(agentId: advertisementDetails.userID ){
            self.showAlert(title: "Report".localize  , message:"You can not report your Advertisement".localize )
        }else{
        if advertisementReportViewModel.checkUserAuth(){
            showReportActionSheet()
        }else{
            self.showAlert(title: "Report".localize , message: "Please Login To Report This Advertisement".localize)
        }
    }
    }
}
