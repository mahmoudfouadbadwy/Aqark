//
//  AdminUsersSearch.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 6/5/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

extension AdminUsersViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        adminUsersViewModel.getFilteredUsers(type: usersSegment.selectedIndex, searchText: searchText)
        usersTableView.reloadData()
        if(self.adminUsersViewModel.adminUsersViewList.isEmpty){
            self.setLabelForZeroCount(search: true)
        }else{
            noLabel.isHidden = true
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

