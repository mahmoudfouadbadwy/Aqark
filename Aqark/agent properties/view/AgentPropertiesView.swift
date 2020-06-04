//
//  AgentPropertiesView.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import Cosmos

class AgentPropertiesView: UIViewController {
    
    @IBOutlet weak var rateHeight: NSLayoutConstraint!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var advertisementsCollection: UICollectionView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rate: CosmosView!
    var agentId:String!
    var agentName:String!
    var agentRateViewModel:AgentRateViewModel!
    let agentDataAccess:AgentDataAccess = AgentDataAccess()
    var listOfAdvertisements:[AgentAdvertisementViewModel] = []{
        didSet{
            if listOfAdvertisements.count>0{
                statusLabel.isHidden = true
            }
            else
            {
                statusLabel.text = "No Advertisements Available"
                statusLabel.isHidden = false
            }
            advertisementsCollection.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgb: 0xf1faee)
        rateLabel.textColor = UIColor(rgb: 0x457b9d)
        advertisementsCollection.backgroundColor = UIColor(rgb: 0xf1faee)
        if(!AgentPropertiesNetworking.checkNetworkConnection())
        {
            statusLabel.isHidden = false
            statusLabel.text = "Internet Connection Not Available"
        }
        self.navigationItem.title = "\(agentName ?? "Agent")'s Properties"
        setupCollection()
    }
    override func viewWillAppear(_ animated: Bool) {
        if(AgentPropertiesNetworking.checkNetworkConnection())
        {
            showActivityIndicator()
            bindCollectionData()
            setupAgentRate()
            statusLabel.isHidden = true
        }
        else
        {
            statusLabel.isHidden = false
            statusLabel.text = "Internet Connection Not Available"
        }
    }
}
