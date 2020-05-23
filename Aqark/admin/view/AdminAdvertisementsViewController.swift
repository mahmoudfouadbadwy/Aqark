//
//  AdminAdvertisementsViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdminAdvertisementsViewController: UIViewController {

    @IBOutlet weak var advertisementsCollectionView: UICollectionView!
    @IBOutlet weak var advertisementsSearchBar: UISearchBar!
    
    private var adminAdvertisementListViewModel : AdminAdvertisementsListViewModel!
    private var dataAccess : AdminDataAccessLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        advertisementsCollectionView.register(UINib(nibName: "AdminAdvertisementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Advertisement Cell")
        dataAccess = AdminDataAccessLayer()
        adminAdvertisementListViewModel = AdminAdvertisementsListViewModel(dataAccess:dataAccess)
        adminAdvertisementListViewModel.populateAdvertisements {
            print("hi")
        }
    }

}
