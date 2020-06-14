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
import SwiftyGif

class SearchViewController: UIViewController,UIActionSheetDelegate{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var labelPlaceHolder: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    var actionButton : JJFloatingActionButton!
    var isMapHidden = true
    let reuseIdentifier = "MyIdentifier"
    var counts: [String: Int] = [:]
      var addressArr = [String]()
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
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var advertismentsListViewModel : AdvertisementListViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    var data : AdvertisementData!
    var sortedList : [AdvertisementViewModel]!
    var adsSortedList : [AdvertisementViewModel]!
    var filteredAdsList:[AdvertisementViewModel]!
    var sort : UIBarButtonItem!
    var sortButton : UIButton!
    var arrOfAdViewModel : [AdvertisementViewModel]!{
        didSet{
            if (arrOfAdViewModel.count > 0 )
            {
                searchBar.isHidden = false
                labelPlaceHolder.isHidden = true
                self.navigationItem.rightBarButtonItem = sort
                
            }
            else
            {
                labelPlaceHolder.text = "No Advertisements Available".localize
                sort = nil
                labelPlaceHolder.isHidden = false
                
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
            setUpSortBtn()
            floationgBtn()
            manageSearchBar()
            limitRegion()
            setupCoredata()
            stopActivityIndicator()
            getCollectionViewData()
            
        }else{
            sort = nil
            labelPlaceHolder.isHidden = false
            labelPlaceHolder.text = "Internet Connection Not Available".localize
            searchCollectionView.isHidden = true
            searchBar.isHidden = true
            
        }
    }
    
    private func setupViews()
    {

        self.navigationItem.title = "Advertisements".localize
        searchBar.barTintColor = UIColor(rgb: 0x1d3557)
        searchBar.backgroundColor = .white
        searchBar.tintColor = .red
        self.view.backgroundColor = UIColor(rgb: 0xf1faee)
        searchCollectionView.backgroundColor = UIColor(rgb: 0xf1faee)

    }
    private func setObjects(){
        maps = []
        sortedList = []
        adsSortedList = []
        actionButton  = JJFloatingActionButton()
    }
    func setUpSortBtn(){
        sortButton = UIButton(type: .custom)
        sortButton.setImage(UIImage(named: "sort"), for: .normal)
        sortButton.addTarget(self, action: #selector(showSortingAlert), for: .touchUpInside)
        
        sortButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        sort = UIBarButtonItem(customView: sortButton)
        self.navigationItem.rightBarButtonItem = sort
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool){
        if advertismentsListViewModel != nil{
            advertismentsListViewModel.removeSearchObserver()
        }
        if actionButton != nil{
            actionButton.removeFromSuperview()
        }
        advertismentsListViewModel = nil
        adViewModel = nil
        data = nil
        actionButton = nil
        mapViewModel = nil
        maps = nil
        collectionViewFlowLayout = nil
        sortedList = nil
        filteredAdsList = nil
        adsSortedList = nil
        coreDataViewModel?.removeCoreDataObject()
        coreDataViewModel = nil
        sort = nil
    }
}



