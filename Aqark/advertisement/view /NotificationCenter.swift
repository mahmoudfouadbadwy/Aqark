//
//  NotificationCenter.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 6/10/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
extension AddAdvertisementViewController
{
    func setupNotificationCenter()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.chnageIndicatorStatus), name: .indicator, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.viewAlert), name: .alert, object: nil)
    }
    
    @objc func chnageIndicatorStatus()
    {
        self.stopActivityIndicator()
        blackIndicatorView.isHidden = true
        
        let alertController = UIAlertController(title: "Advertisements".localize, message: "Advertrisement saved successfully".localize , preferredStyle: .alert)
        let actionButton = UIAlertAction(title: "ok", style: .default) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(actionButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func viewAlert()
    {
        
        self.stopActivityIndicator()

        var alert = UIAlertController(title: "pay", message: "you are used all your free advertisements", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "ok".localize, style: .default , handler:{ (UIAlertAction)in
                PurchaseManager.instance.purchasePremiumAdvertisement{ [weak self] success in
                         if success {
                             self?.showActivityIndicator()
                             self?.addAdvertisementVM.payment = "premium"
                             self?.addAdvertisementVM.save()
                                   }
                     }
               
               }))
        self.present(alert, animated: true, completion: nil)
    }
        
        
//        blackIndicatorView.isHidden = false
     
    
}

//MARK: - notification center

extension Notification.Name{
    static let indicator = Notification.Name("indicator")
    static let alert = Notification.Name("alert")
}

 
