//
//  SearchViewController.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import SDWebImage
import JJFloatingActionButton
import MapKit
import Foundation

class SearchViewController: UIViewController,UIActionSheetDelegate{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var labelPlaceHolder: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    var coreDataViewModel: CoreDataViewModel?
    var optionalValue : AdvertisementViewModel!
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
    var sortedList = [AdvertisementViewModel]()
    var adsSortedList = [AdvertisementViewModel]()
    var filteredAdsList:[AdvertisementViewModel]!
    var unFilteredAdsList = [AdvertisementViewModel]()
    var arrOfAdViewModel : [AdvertisementViewModel]!{
        didSet{
            if (arrOfAdViewModel.count>0 )
            {
                
                searchBar.isHidden = false
                self.manageAppearence(sortBtn: false, labelPlaceHolder: true, notificationBtn: true)
            }
            else
            {
                labelPlaceHolder.text = "No Advertisements Available"
                self.manageAppearence(sortBtn: true, labelPlaceHolder: false, notificationBtn: true)
            }
            self.searchCollectionView.reloadData()
        }
    }
    var searchBarText:String!
    {
        didSet{
            filterContentForSearchBarText(searchBar.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Advertisements"
        if SearchNetworking.checkNetworkConnection(){
            manageSearchBar()
            setupCoredata()
            setUpCollectionView()
            floationgBtn()
            limitRegion()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if SearchNetworking.checkNetworkConnection(){
            if  !isFiltering  {
                
                getCollectionViewData()
            }
        }else{
            manageAppearence(sortBtn: true, labelPlaceHolder: false, notificationBtn: true)
            labelPlaceHolder.text = "Internet Connection Not Available"
        }
    }
    
    func manageAppearence(sortBtn: Bool, labelPlaceHolder : Bool,notificationBtn : Bool ){
        self.sortBtn.isHidden = sortBtn
        self.labelPlaceHolder.isHidden = labelPlaceHolder
        self.notificationBtn.isHidden = notificationBtn
    }
    
    @IBAction func showSortingActionSheet(_ sender: Any) {
        showSortingAlert()
    }
    
}




