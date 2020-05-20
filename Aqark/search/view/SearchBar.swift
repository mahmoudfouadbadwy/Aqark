//
//  SearchBar.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/18/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension SearchViewController:  UISearchBarDelegate{

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        appearAutoCompleteData()
        filterContentForSearchBarText(searchBar.text!)
    }
    
func filterContentForSearchBarText(_ searchText: String){
        let advertisementList = advertismentsListViewModel.advertismentsViewModel
        unFilteredAdsList = advertisementList
        let searchText = searchBar.text ?? ""
        filteredAdsList = advertisementList.filter { advertisement -> Bool in
            return advertisement.address.lowercased().contains(searchText.lowercased())
        }
        searchCollectionView.reloadData()
    }
    
   var isFiltering: Bool {
        return (searchBar.text?.isEmpty)! && !searchController.isActive ? false : true
    }
    
    
}
