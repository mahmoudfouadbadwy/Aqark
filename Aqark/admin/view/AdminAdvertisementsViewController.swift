//
//  AdminAdvertisementsViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdminAdvertisementsViewController: UIViewController {

    @IBOutlet weak var customSegment: CustomSegment!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func selectedValueChanged(_ sender: Any) {
        print(customSegment.selectedIndex)
    }
}
