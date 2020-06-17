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
        
         blackIndicatorView.isHidden = true
    }
    
    @objc func viewAlert()
    {

        self.stopActivityIndicator()
        let alert = UIAlertController(title: "Premium Advertisement", message: "Sorry, you have used all of your free ads, continue to add premium ad for 99 EGP", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "ok".localize, style: .default , handler:{ (UIAlertAction)in
                PurchaseManager.instance.purchasePremiumAdvertisement{ [weak self] success in
                         if success {
                             self?.showActivityIndicator()
                            self?.addAdvertisementVM?.payment = "premium"
                            self?.addAdvertisementVM?.save()
                            }
                     }
               }))
         alert.addAction(UIAlertAction(title: "Cancel".localize, style: .default, handler:{ (UIAlertAction)in
           alert.dismiss(animated: true)
            self.blackIndicatorView.isHidden = true
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

//MARK: - notification center
extension Notification.Name{
    static let indicator = Notification.Name("indicator")
    static let alert = Notification.Name("alert")
}

 
