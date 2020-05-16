//
//  SearchViewController.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import GooglePlaces
import ReachabilitySwift
import SDWebImage


class SearchViewController: UIViewController{
    
    @IBOutlet weak var placeHolderView: UIView!
    @IBOutlet weak var labelPlaceHolder: UILabel!
    @IBOutlet weak var imagePlaceHolder: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    var collectionViewFlowLayout:UICollectionViewFlowLayout!
    var advertismentsListViewModel : AdvertisementListViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    private var data : AdvertisementData!
    private var filteredAdsList = [AdvertisementViewModel]()
    private var unFilteredAdsList = [AdvertisementViewModel]()
    private let networkIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private var arrOfAdViewModel : [AdvertisementViewModel]?{
        didSet{
            self.searchCollectionView.reloadData()
            stopIndicator()

        }
    }
    private var searchBarText:String!{
        didSet{
            filterContentForSearchBarText(searchBar.text!)
            if filteredAdsList.count == 0 {
                placeHolderView.isHidden = false
                imagePlaceHolder.image = UIImage(named: "search_not_found")
                labelPlaceHolder.text = "No Advertisements Found"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !checkNetworkConnection(){
           placeHolderView.isHidden = false
            imagePlaceHolder.image = UIImage(named: "search_no_connection")
            labelPlaceHolder.text = "No Internet Connection"


            
        }else{
        placeHolderView.isHidden = true
        showIndicator()
         searchBar.delegate = self
         searchCollectionView.register(UINib(nibName: "AdvertisementCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        updateFlowLayout()
        searchComponents()
        self.data = AdvertisementData()
        self.advertismentsListViewModel = AdvertisementListViewModel(dataAccess: self.data)
        
        advertismentsListViewModel.populateAds { (dataResults) in
            self.arrOfAdViewModel = dataResults
            
        }
          searchCollectionView.reloadData()
    }
        
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


//MARK: CollectionView

extension SearchViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if advertismentsListViewModel != nil{
        return isFiltering ? filteredAdsList.count : advertismentsListViewModel.advertismentsViewModel.count
        }else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AdvertisementCellCollectionViewCell
        var adViewModel : AdvertisementViewModel
        
        if isFiltering {
            adViewModel = filteredAdsList[indexPath.row]
        } else {
            if let arrOfAdViewModel = arrOfAdViewModel{
                adViewModel = arrOfAdViewModel[indexPath.row]
            }
            else{
                adViewModel = self.advertismentsListViewModel.advertismentsViewModel[indexPath.row]
            }
        }
        
        cell.advertisementImage?.sd_setImage(with: URL(string: adViewModel.image), placeholderImage: UIImage(named: "search_apartment"))
//        cell.advertisementImage?.image = UIImage(named: adViewModel.image)
        cell.propertyTypeLabel?.text = adViewModel.propertyType
        cell.proprtyAddressLabel?.text = adViewModel.address
        cell.propertyPriceLabel?.text = adViewModel.price
        cell.numberOfBedsLabel?.text = adViewModel.bedRoomsNumber
        cell.numberOfBathRoomsLabel?.text = adViewModel.bathRoomsNumber
        cell.propertySizeLabel?.text = adViewModel.size
        return cell
    }
    
    func updateFlowLayout()
    {
        if collectionViewFlowLayout == nil
        {
            let numberOfItemPerRow :CGFloat = 1
            let minimunLineSpacing :CGFloat = 0
            let minimunInteritemSpacing :CGFloat = 0
            
            let width = (searchCollectionView.frame.width / numberOfItemPerRow)
            let height = (searchCollectionView.frame.height/3)
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.minimumLineSpacing = minimunLineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = minimunInteritemSpacing
            searchCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
}

//MARK: AutoComplete View Controller
extension SearchViewController:  GMSAutocompleteViewControllerDelegate{
  
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Get the place name from 'GMSAutocompleteViewController'
           searchBar.text = place.name
        
        // Then display the name in textField
        searchBarText = searchBar.text

        // Dismiss the GMSAutocompleteViewController when something is selected
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
    
    //autocomplete
  private func appearAutoCompleteData(){
        
        searchBar.resignFirstResponder()
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        filter.country = "eg"
        autocompleteController.autocompleteFilter = filter;
        present(autocompleteController, animated: true, completion: nil)
    }
}

//MARK: Search Bar
extension SearchViewController:  UISearchBarDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.becomeFirstResponder()
        appearAutoCompleteData()
        filterContentForSearchBarText(searchBar.text!)
    }
    
   private func filterContentForSearchBarText(_ searchText: String){
        let advertisementList = advertismentsListViewModel.advertismentsViewModel
        unFilteredAdsList = advertisementList
        let searchText = searchBar.text ?? ""
        filteredAdsList = advertisementList.filter { advertisement -> Bool in
        return advertisement.address.lowercased().contains(searchText.lowercased())
        }
        searchCollectionView.reloadData()
    }
    
     private var isFiltering: Bool {
        return (searchBar.text?.isEmpty)! && !searchController.isActive ? false : true
    }
    
    func searchComponents() {
        searchController.searchBar.placeholder = "Search Location"
        //for iOS 11, you add the searchBar to the navigationItem. This is necessary because Interface Builder is not yet compatible with UISearchController.
        navigationItem.searchController = searchController
        // by setting definesPresentationContext on your view controller to true, you ensure that the search bar doesn’t remain on the screen if the user navigates to
        definesPresentationContext = true
    }
}


