//
//  PaymentViewController.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 5/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import StoreKit


class PaymentViewController: UIViewController {

    @IBOutlet weak var premiumAdvertisementButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    @IBAction func makePremiumAdvertisement(_ sender: Any) {
        PurchaseManager.instance.purchasePremiumAdvertisement{ success in
            if success {
                self.premiumAdvertisementButton.backgroundColor = .red
            }else{
            }
        }
            
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
