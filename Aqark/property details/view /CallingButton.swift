//
//  Calling Button.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/25/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import Foundation
extension PropertyDetailView{
    
    func configureCallingButton()
    {
        callButton.addItem(title: "call", image: UIImage(named: "phone")?.withRenderingMode(.alwaysTemplate)) { item in
               self.makePhoneCall()
        }
        view.addSubview(callButton)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        callButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
    
    func makePhoneCall() {
        if let phoneURL = URL(string: ("tel://" + self.advertisementDetails.phone)) {
            showCallAlert(phone: phoneURL)
        }
    }
    
    
    func showCallAlert(phone:URL)
    {
        let alert = UIAlertController(title: "Call".localize, message: "Are You Sure You Want To Call Property Agent ?".localize, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Call".localize, style: .default, handler: { (action) in
            UIApplication.shared.open(phone,options:[:],completionHandler: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localize, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}
