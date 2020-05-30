//
//  FavouriteViewController.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    var coreDataViewModel: CoreDataViewModel?
    var favouriteListViewModel : FavouriteListViewModel!
    var adViewModel: FavouriteViewModel!
    var dataAccess: FavouriteDataAccess!
    var arrOfAdViewModel : [FavouriteViewModel]!{
        didSet{
            self.favouriteCollectionView.reloadData()
            
           
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favourite"
        let fda:FavouriteDataAccess=FavouriteDataAccess()
        print(" fda.getFavouriteAdsFromCoredata()  \(fda.getFavouriteAdsFromCoredata())")
        setupCoredata()
        setUpCollectionView()
        getCollectionViewData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.favouriteCollectionView.reloadData()
    }

}
