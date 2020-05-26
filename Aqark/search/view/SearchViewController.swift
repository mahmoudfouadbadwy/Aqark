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
import JJFloatingActionButton
import MapKit
import Foundation

class SearchViewController: UIViewController,UIActionSheetDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var swapLabel: UIImageView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var labelPlaceHolder: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    let actionButton = JJFloatingActionButton()
    var isMapHidden = true
    let reuseIdentifier = "MyIdentifier"
    var counts: [String: Int] = [:]
    var numberOfPropertiesInLocation : Int!
    var addressForMap : String!
    var adViewModel : AdvertisementViewModel!
    var maps: [Map] = []
    var arrayOfLongitude = [Double]()
    var latitude : Double = 0
    var longitude : Double = 0
    var isSorting: String = "default"
    var collectionViewFlowLayout:UICollectionViewFlowLayout!
    var advertismentsListViewModel : AdvertisementListViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    var data : AdvertisementData!
    var filteredAdsList = [AdvertisementViewModel]()
    var sortedList = [AdvertisementViewModel]()
    var adsSortedList = [AdvertisementViewModel]()
    var unFilteredAdsList = [AdvertisementViewModel]()
    let networkIndicator = UIActivityIndicatorView(style: .whiteLarge)
    var arrOfAdViewModel : [AdvertisementViewModel]!{
        didSet{
            self.searchCollectionView.reloadData()
            stopIndicator()
            notificationBtn.isHidden = false
            searchBar.isHidden = false
            filterBtn.isHidden = false
            filterImage.isHidden = false
            self.manageAppearence(sortBtn: false, swapLabel: false, labelPlaceHolder: true)
            UIView.animate(withDuration:2) {
                self.view.alpha = 1
            }
        }
    }
    var searchBarText:String!{
        didSet{
            filterContentForSearchBarText(searchBar.text!)
            if filteredAdsList.count == 0 {
                labelPlaceHolder.text = "No Advertisements Found"
                self.manageAppearence(sortBtn: true, swapLabel: true, labelPlaceHolder: false)
            }
    }
}
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !checkNetworkConnection(){
            labelPlaceHolder.isHidden = false
            self.view.alpha = 1
            labelPlaceHolder.text = "No Internet Connection"
        }else{
            manageSearchBar()
            showIndicator()
            setUpCollectionView()
            getCollectionViewData()
            floationgBtn()
            labelPlaceHolder.isHidden = true
        }
    }

    func manageAppearence(sortBtn: Bool,swapLabel: Bool, labelPlaceHolder : Bool ){
        self.sortBtn.isHidden = sortBtn
        self.swapLabel.isHidden = swapLabel
        self.labelPlaceHolder.isHidden = labelPlaceHolder
    }
    
    @IBAction func showSortingActionSheet(_ sender: Any) {
        showSortingAlert()
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



