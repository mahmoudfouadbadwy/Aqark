//
//  SearchViewController.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import GooglePlaces

class SearchViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate{
   
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    var collectionViewFlowLayout:UICollectionViewFlowLayout!
    var advertismentsListViewModel : AdvertismentsListViewModel!
    private var data : AdvertisementData!
    private var filteredAdsList = [AdvertisementViewModel]()
    private var unFilteredList = [AdvertisementViewModel]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    searchCollectionView.register(UINib(nibName: "AdvertisementCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
      
        updateFlowLayout()
        
        searchBar.delegate = self
        
        self.data = AdvertisementData()
        self.advertismentsListViewModel = AdvertismentsListViewModel(data: self.data)
        
        /////////////
        // 1
//        searchController.searchResultsUpdater = self
       
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Location"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        ////////////
     
        searchCollectionView.reloadData()
        
      

    }
    
    
    
 
    func getAddressesArr() -> [String]{
        
        let array = advertismentsListViewModel.advertismentsViewModel
        var addressArr = [String]()
        for ad in array {
            addressArr.append(ad.address)
        }
      
        return addressArr
        
    }
    var address:String!{
        didSet{
            filterSearchController(searchBar.text!)
        
        }
    }
    
  

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
             print(filteredAdsList)
            return filteredAdsList.count
           
        }
        print(advertismentsListViewModel.advertismentsViewModel.count)
        return advertismentsListViewModel.advertismentsViewModel.count
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AdvertisementCellCollectionViewCell
        var adViewModel : AdvertisementViewModel
        print(isFiltering)
        print(filteredAdsList.count)
        
        if isFiltering {
            adViewModel = filteredAdsList[indexPath.row]
        } else {
            adViewModel = self.advertismentsListViewModel.advertismentsViewModel[indexPath.row]
        }
        

        cell.advertisementImage?.image = adViewModel.image
        cell.propertyTypeLabel?.text = adViewModel.propertyType
        cell.propertyPriceLabel?.text = adViewModel.price
        cell.proprtyAddressLabel?.text = adViewModel.address
        cell.numberOfBedsLabel?.text = adViewModel.bedRoomsNumber
        cell.numberOfBathRoomsLabel?.text = adViewModel.bathRoomsNumber
        cell.propertySizeLabel?.text = adViewModel.size
        
      

        return cell
    }
    var isFiltering: Bool {
//        return searchController.isActive && !isSearchBarEmpty
    
        if (searchBar.text?.isEmpty)! && !searchController.isActive{
            
            return false
        }
        return true
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
    
    /**
     search autocomplete
     **/
    
   
    
    func appearAutoCompleteData(){

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
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
   
    func filterSearchController(_ searchText: String){
        let advertisementList = advertismentsListViewModel.advertismentsViewModel
        unFilteredList = advertisementList
         let searchText = searchBar.text ?? ""

    
            filteredAdsList = advertisementList.filter { advertisement -> Bool in
                return advertisement.address.lowercased().contains(searchText.lowercased())
            }
        print(filteredAdsList.count)
        
    searchCollectionView.reloadData()
        }

}
extension SearchViewController:  GMSAutocompleteViewControllerDelegate{
  
//    UISearchResultsUpdating,
//    func updateSearchResults(for searchViewController: UISearchController) {
////          filterSearchController(searchBar.text!)
//        print("ssssssssss")
//    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.becomeFirstResponder()
        appearAutoCompleteData()
         filterSearchController(searchBar.text!)
    }
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Get the place name from 'GMSAutocompleteViewController'
        // Then display the name in textField
        
        searchBar.text = place.name
        address = searchBar.text
      
    

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


}
