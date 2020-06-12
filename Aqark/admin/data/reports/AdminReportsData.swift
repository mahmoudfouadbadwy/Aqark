//
//  AdminReportsData.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/31/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Firebase

class AdminReportsData{
    var reportsStore:AdminReportsStore = AdminReportsStore(reports: [])
    var users:[String]=[]
    var agents:[String]=[]
    var reportRef:DatabaseReference! = Database.database().reference()
    var userRef:DatabaseReference! = Database.database().reference()
    func getAdminReports(completion:@escaping([AdminReport],[String],[String])->Void)
    {
       
        reportRef.child("Reports").observe(.value) {[weak self ](snapshoot) in
            if snapshoot.exists(){
                self?.reportsStore.reports.removeAll()
                self?.agents.removeAll()
                self?.users.removeAll()
                let reports = snapshoot.value as! NSDictionary
                var index:Int = 0
                for report in reports{
                    let reportData = report.value as? [String:String]
                    let adminReport = AdminReport(reportId:reports.allKeys[index] as! String, reportContent: reportData?["ReportText"] ?? "", userId: reportData?["UserId"] ?? "", agentId: reportData?["AgentId"] ?? "", advertisementId: reportData?["AdvertisementId"] ?? "")
                    self?.reportsStore.addReport(report: adminReport)
                    index += 1
                    self?.getUserName(userId: reportData?["UserId"] ?? "", completion: {
                        (user) in
                        self?.users.append(user)
                    })
                    self?.getUserName(userId: reportData?["AgentId"] ?? "", completion: {
                        (agent) in
                        self?.agents.append(agent)
                        
                        if (self?.agents.count == reports.count)
                        {
                            completion(self?.reportsStore.reports ?? [],self?.users ?? [],self?.agents ?? [])
                        }
                        
                    })
                }
            }
            else
            {
                completion([],[],[])
            }
        }
    }
    private func getUserName(userId:String,completion:@escaping(String)->Void){
        userRef.child("Users").child(userId).observeSingleEvent(of: .value) { (snapshoot) in
            if snapshoot.exists(){
                let user = snapshoot.value as? NSDictionary
                let username = user?["username"] ?? ""
                completion(username as! String)
            }else
            {
                completion("")
            }
        }
    }
    
    func deleteReport(reportId:String)
    {
        let ref = Database.database().reference()
        ref.child("Reports").child(reportId).removeValue()
    }
    
    
    func removeReportObservers()
    {
        reportRef.child("Reports").removeAllObservers()
        reportRef = nil
        guard let userID = Auth.auth().currentUser?.uid else {return}
        userRef.child("Users").child(userID).removeAllObservers()
        userRef = nil
    }
}
