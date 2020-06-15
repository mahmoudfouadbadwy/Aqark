//
//  AdminReportsView.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/31/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdminReportsView: UIViewController {
    @IBOutlet weak var reportsCollection: UICollectionView!
    @IBOutlet weak var statusLabel: UILabel!
    var usersname:[String]!
    var agentsname:[String]!
    weak var adminAdvertisementReportDelegate:AdminAdvertisementsReportDelegate!
    var adminReportViewModel:AdminReportsList!
    var reportData:AdminReportsData!
    var reports:[AdminReportViewModel]!=[]{
        didSet{
            if reports.count == 0{
                statusLabel.isHidden = false
                statusLabel.text = "No Reports Available"
            }
            else
            {
                statusLabel.isHidden = true
            }
            reportsCollection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupReportsCollection()
        setupCollectionGeusture()
        
        view.backgroundColor = UIColor(rgb: 0xf1faee)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.navigationItem.title = "Reports"
        if ReportNetwork.checkNetworkConnection(){
            bindCollectionData()
        }
        else
        {
            setupNoConnectionView()
        }
    }
    
    private func setupNoConnectionView()
    {
        statusLabel.isHidden = false
        statusLabel.text = "Internet Connetion Not Available"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if adminReportViewModel != nil {
            adminReportViewModel.removeObservers()
        }
        adminReportViewModel = nil
        reportData = nil
    }
    
    deinit {
        reports = nil
    }
    
}

