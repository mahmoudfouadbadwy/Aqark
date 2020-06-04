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
    var adViewModel: FavouriteViewModel!
    var adsCount:Int=0
    var favouriteListViewModel : FavouriteListViewModel=FavouriteListViewModel(dataAccess: FavouriteDataAccess())
    var arrOfAdViewModel : [FavouriteViewModel]=[FavouriteViewModel](){
        didSet{
            if arrOfAdViewModel.count == 0{
                setEmptyAdvertisments(flag: false)
            }else{
                setEmptyAdvertisments(flag: true)
            }
            self.favouriteCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favourite"
        self.view.backgroundColor = UIColor(rgb: 0xf1faee)
        favouriteCollectionView.backgroundColor = UIColor(rgb: 0xf1faee)
        self.setupCoredata()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if !checkNetworkConnection(){
            favouriteCollectionView.isHidden = true
            labelPlaceHolder.text = "Internet connection not available"
        }else{
            labelPlaceHolder.isHidden = true
            getCollectionViewData()
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
    
    func setEmptyAdvertisments(flag: Bool){
        self.labelPlaceHolder.isHidden = flag
        self.labelPlaceHolder.text = "There is no advertisements in favourite list."
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

