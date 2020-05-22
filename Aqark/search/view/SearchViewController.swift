//
//  SearchViewController.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import ReachabilitySwift
import SDWebImage

class SearchViewController: UIViewController,UIActionSheetDelegate{
    
    
    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var swapLabel: UIImageView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var placeHolderView: UIView!
    @IBOutlet weak var labelPlaceHolder: UILabel!
    @IBOutlet weak var imagePlaceHolder: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    var isSorting: String = "default"
    var collectionViewFlowLayout:UICollectionViewFlowLayout!
    var advertismentsListViewModel : AdvertisementListViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    var data : AdvertisementData!
    var filteredAdsList = [AdvertisementViewModel]()
    var sortedAdsListByHighPrice = [AdvertisementViewModel]()
    var sortedAdsListByLowPrice = [AdvertisementViewModel]()
    var sortedAdsListByNewestDate = [AdvertisementViewModel]()
    var sortedAdsListByOldestDate = [AdvertisementViewModel]()
    var unFilteredAdsList = [AdvertisementViewModel]()
    let networkIndicator = UIActivityIndicatorView(style: .whiteLarge)
    var arrOfAdViewModel : [AdvertisementViewModel]?{
        didSet{
            self.searchCollectionView.reloadData()
            stopIndicator()
            swapLabel.isHidden = false
            notificationBtn.isHidden = false
            sortBtn.isHidden = false
            searchBar.isHidden = false
            filterBtn.isHidden = false
            filterImage.isHidden = false
            UIView.animate(withDuration:2) {
                self.view.alpha = 1
            }
        }
    }
    var searchBarText:String!{
        didSet{
            filterContentForSearchBarText(searchBar.text!)
            if filteredAdsList.count == 0 {
                placeHolderView.isHidden = false
                imagePlaceHolder.image = UIImage(named: "search_not_found")
                labelPlaceHolder.text = "No Advertisements Found"
                sortBtn.isHidden = true
                swapLabel.isHidden = true
            }else{
                placeHolderView.isHidden = true
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !checkNetworkConnection(){
            placeHolderView.isHidden = false
            self.view.alpha = 1
            imagePlaceHolder.image = UIImage(named: "search_no_connection")
            labelPlaceHolder.text = "No Internet Connection"
        }else{
            showIndicator()
            placeHolderView.isHidden = true
            searchBar.delegate = self
            searchBar.layer.borderWidth = 1
            searchBar.layer.cornerRadius = 5
            searchBar.layer.shadowColor = UIColor.lightGray.cgColor
            searchBar.layer.borderColor = UIColor.lightGray.cgColor
            if let textField = self.searchBar.subviews.first?.subviews.compactMap({ $0 as? UITextField }).first {
                textField.subviews.first?.isHidden = true
                textField.layer.backgroundColor = UIColor.white.cgColor
                textField.layer.masksToBounds = true
            }
            searchCollectionView.register(UINib(nibName: "AdvertisementCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
            updateFlowLayout()
            self.data = AdvertisementData()
            self.advertismentsListViewModel = AdvertisementListViewModel(dataAccess: self.data)
            advertismentsListViewModel.populateAds {
                (dataResults) in
                if dataResults.isEmpty{
                    self.stopIndicator()
                    self.placeHolderView.isHidden = false
                    self.imagePlaceHolder.image = UIImage(named: "search_not_found")
                    self.labelPlaceHolder.text = "No Advertisements Found"
                    self.sortBtn.isHidden = true
                    self.swapLabel.isHidden = true
                }else{
                    //            self.arrOfAdViewModel?.removeAll()
                    self.arrOfAdViewModel = dataResults
                    self.sortedAdsListByHighPrice = self.arrOfAdViewModel?.sorted{
                        $0.price > $1.price
                        } as! [AdvertisementViewModel]
                    
                    self.sortedAdsListByLowPrice = self.arrOfAdViewModel?.sorted{
                        $0.price < $1.price
                        } as! [AdvertisementViewModel]
                    self.sortedAdsListByNewestDate = self.arrOfAdViewModel?.sorted{
                        $0.advertisementDate > $1.advertisementDate
                        } as! [AdvertisementViewModel]
                    self.sortedAdsListByOldestDate = self.arrOfAdViewModel?.sorted{
                        $0.advertisementDate < $1.advertisementDate
                        } as! [AdvertisementViewModel]
                }
            }
        }
    }
    
    
    
    @IBAction func showSortingActionSheet(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Price(High)", style: .default , handler:{ (UIAlertAction)in
            print("User click high price button")
            self.isSorting = "High Price"
            self.searchCollectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Price(Low)", style: .default , handler:{ (UIAlertAction)in
            print("User click low price button")
            self.isSorting = "Low Price"
            self.searchCollectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Newest", style: .default , handler:{ (UIAlertAction)in
            print("User click newest button")
            self.isSorting = "Newest"
            self.searchCollectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Oldest", style: .default , handler:{ (UIAlertAction)in
            print("User click oldest button")
            self.isSorting = "Oldest"
            self.searchCollectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Default", style: .default , handler:{ (UIAlertAction)in
                  print("User click oldest button")
                  self.isSorting = "default"
                  self.searchCollectionView.reloadData()
              }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    
    
    func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
}

//MARK: - UIViewIndicator
extension SearchViewController{
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



