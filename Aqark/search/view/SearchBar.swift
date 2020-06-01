//
//  SearchBar.swift
//  Aqark
//
//  Created by shorouk mohamed on 5/18/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension SearchViewController:  UISearchBarDelegate{
    
    func manageSearchBar(){
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
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        appearAutoCompleteData()
        filterContentForSearchBarText(searchBar.text!)
    }
    
    func filterContentForSearchBarText(_ searchText: String){
        let searchText = searchBar.text ?? ""
        advertismentsListViewModel.populateAds {
        (dataResults) in
       
            self.arrOfAdViewModel = dataResults
            self.filteredAdsList = dataResults.filter { advertisement -> Bool in
        return advertisement.address.lowercased().contains(searchText.lowercased())
        }
//        filteredAdsList = arrOfAdViewModel.filter { advertisement -> Bool in
//            return advertisement.address.lowercased().contains(searchText.lowercased())
//        }
            self.searchCollectionView.reloadData()
    }
    }
    var isFiltering: Bool {
        return (searchBar.text?.isEmpty)! && !searchController.isActive ? false : true
    }
    
    
}
