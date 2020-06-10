//
//  ReportsCollection.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/31/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit
extension AdminReportsView{
    func setupReportsCollection()
    {  
        self.reportsCollection.register(UINib(nibName: "AdminReportsCell", bundle: nil), forCellWithReuseIdentifier: "reportsCell")
        self.reportsCollection.delegate = self
        self.reportsCollection.dataSource = self
        reportsCollection.backgroundColor = UIColor(rgb: 0xf1faee)
        view.backgroundColor = UIColor(rgb: 0xf1faee)
    }
    func bindCollectionData()
    {
        showActivityIndicator()
         self.adminReportViewModel = AdminReportsList(reportData:  AdminReportsData())
        self.adminReportViewModel.getAllReports(completion: {[weak self]
            (reports,users,agents) in
            self?.reports = reports
            self?.usersname  = users
            self?.agentsname = agents
            self?.stopActivityIndicator()
        })
    }
    
    private func setCellConfiguration(cell:UICollectionViewCell)
    {
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    
}

extension AdminReportsView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _ =  usersname, let _ = agentsname else { return 0}
        return self.reports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AdminReportsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "reportsCell", for: indexPath) as! AdminReportsCell
        cell.reportContent.text =
            "\(usersname[indexPath.row]) report \(agentsname[indexPath.row])'s advertisement for \(reports[indexPath.row].reportContent)"
        setCellConfiguration(cell:cell)
        return cell
    }
}

extension AdminReportsView:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AdminAdvertisementsViewController.reportedAdvertisementId = reports[indexPath.row].advertisementId
        self.tabBarController?.selectedIndex = 1
    }
}


extension AdminReportsView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 40, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}




extension AdminReportsView:UIGestureRecognizerDelegate{
    func setupCollectionGeusture()
    {
        let gesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(deleteCell(gesture:)))
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        self.reportsCollection.addGestureRecognizer(gesture)
    }
    
    @objc private func deleteCell(gesture:UILongPressGestureRecognizer )
    {
        if (gesture.state != .ended)
        {
            return
        }else
        {
            let  point = gesture.location(in: self.reportsCollection)
            if let indexPath =  self.reportsCollection.indexPathForItem(at: point)
            {
                showAlert(completion: {[weak self] (res) in
                    if (res)
                    {
                        self?.reportsCollection.performBatchUpdates({
                            // delete from firebase.
                    self?.adminReportViewModel.deleteReport(reportId:self?.reports[indexPath.row].reportId ?? "")
                            // delete from view .
                            self?.reports.remove(at: indexPath.row)
                            self?.reportsCollection.deleteItems(at: [indexPath])
                        }) { (finished) in
                            self?.reportsCollection.reloadData()
                        }
                    }
                })
            }
        }
    }
    
    private func showAlert(completion:@escaping(Bool)->Void)
    {
        let alert:UIAlertController = UIAlertController(title: "Delete Report", message: "Are You Sure You Want To Delete This Report ?", preferredStyle: .actionSheet)
        let delete:UIAlertAction = UIAlertAction(title: "Delete", style: .default) { (action) in
            completion(true)
        }
        let cancel:UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true)
            completion(false)
        }
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}

