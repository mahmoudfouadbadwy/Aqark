//
//  FavouriteViewController.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import ReachabilitySwift

class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    @IBOutlet weak var labelPlaceHolder: UILabel!
    let networkIndicator = UIActivityIndicatorView(style: .whiteLarge)
    var coreDataViewModel: CoreDataViewModel?
    var adViewModel: FavouriteModel!
    var dataAccess: FavouriteDataAccess!
    var adsCount:Int=0
    var arrOfAdViewModel : [FavouriteModel]=[FavouriteModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favourite"
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if !checkNetworkConnection(){
            favouriteCollectionView.isHidden = true
            labelPlaceHolder.text = "Internet connection not available"
        }else{
            labelPlaceHolder.isHidden = true
            showIndicator()
            self.setupCoredata()
            setUpCollectionView()
            getCollectionViewData()
            showDeletedAdsAlert()
            self.favouriteCollectionView.reloadData()
        }
    }
    
    func showDeletedAdsAlert(){
        if (adsCount != 0){
            let alert = UIAlertController(title: "Deleted Advertisment", message: " There are \(adsCount) Advertisment deleted from your Favourite List ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            adsCount=0
        }
    }

    func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
    
}

//MARK: - UIViewIndicator
extension FavouriteViewController{
    func showIndicator()
    {
        networkIndicator.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        networkIndicator.center = view.center
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
    }
    
    func stopIndicator() {
        networkIndicator.stopAnimating()
    }
}

