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
    var actionButton : JJFloatingActionButton!
    var isMapHidden = true
    let reuseIdentifier = "MyIdentifier"
    var counts: [String: Int] = [:]
    var numberOfPropertiesInLocation : Int!
    var addressForMap : String!
    var adViewModel : AdvertisementViewModel!
    var mapViewModel : MapViewModel!
    var maps : [MapViewModel]!
    var latitude : Double = 0
    var longitude : Double = 0
    var isSorting: String = "default"
    var isSorted = false
    var coreDataViewModel : CoreDataViewModel?
    var coreDataAccess : CoreDataAccess!
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var advertismentsListViewModel : AdvertisementListViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    var data : AdvertisementData!
    var sortedList : [AdvertisementViewModel]!
    var adsSortedList : [AdvertisementViewModel]!
    var filteredAdsList:[AdvertisementViewModel]!
    var arrOfAdViewModel : [AdvertisementViewModel]!{
        didSet{
            if (arrOfAdViewModel.count > 0 )
            {
                searchBar.isHidden = false
                self.manageAppearence(sortBtn: false, labelPlaceHolder: true, notificationBtn: true)
            }
            else
            {
                labelPlaceHolder.text = "No Advertisements Available".localize
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
        setupViews()
        setUpCollectionView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if SearchNetworking.checkNetworkConnection(){
               searchCollectionView.isHidden = false
            setObjects()
            floationgBtn()
            manageSearchBar()
            limitRegion()
            setupCoredata()
            getCollectionViewData()
            stopActivityIndicator()
        }else{
            manageAppearence(sortBtn: true, labelPlaceHolder: false, notificationBtn: true)
            labelPlaceHolder.text = "Internet Connection Not Available".localize
            searchCollectionView.isHidden = true
            
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
    
    private func setupViews()
    {
        self.navigationItem.title = "AQARK".localize
        sortBtn.setTitleColor(UIColor(rgb: 0x1d3557), for: .normal)
        notificationBtn.setTitleColor(UIColor(rgb: 0x1d3557), for: .normal)
        searchBar.barTintColor = UIColor(rgb: 0x1d3557)
        self.view.backgroundColor = UIColor(rgb: 0xf1faee)
        searchCollectionView.backgroundColor = UIColor(rgb: 0xf1faee)
    }
    private func setObjects(){
        maps = []
        sortedList = []
        adsSortedList = []
        actionButton  = JJFloatingActionButton()
    }
    
    override func viewWillDisappear(_ animated: Bool){
         if  advertismentsListViewModel != nil {
            advertismentsListViewModel.removeSearchObserver()
        }
        if coreDataViewModel != nil{
            coreDataViewModel?.removeCoreDataObject()
        }
        if actionButton != nil{
            actionButton.removeFromSuperview()
        }
        actionButton = nil
        advertismentsListViewModel = nil
        adViewModel = nil
        data = nil
        mapViewModel = nil
        maps = nil
        collectionViewFlowLayout = nil
        sortedList = nil
        filteredAdsList = nil
        adsSortedList = nil
        coreDataViewModel = nil
        coreDataAccess = nil
    }
  
   
}



