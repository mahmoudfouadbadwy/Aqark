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
    var adminReportViewModel:AdminReportsList!
    var reports:[AdminReportViewModel]=[]{
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
    var usersname:[String]!
    var agentsname:[String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        if !ReportNetwork.checkNetworkConnection(){
            statusLabel.isHidden = false
            statusLabel.text = "Internet Connetion Not Available"
        }
        setupReportsCollection()
        setupCollectionGeusture()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        if ReportNetwork.checkNetworkConnection(){
            bindCollectionData()
        }
        else
        {
            statusLabel.isHidden = false
            statusLabel.text = "Internet Connetion Not Available"
        }
    }
    
}

