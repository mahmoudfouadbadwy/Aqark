//
//  SortingExtenision.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 5/23/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension SearchViewController{
    
    func sortData(str : String)->[AdvertisementViewModel]{
        switch str {
        case "High Price":
            self.adsSortedList = self.arrOfAdViewModel.sorted{
                $0.price > $1.price
                }
        case "Low Price":
            self.adsSortedList = self.arrOfAdViewModel.sorted{
                $0.price < $1.price
                }
        case "Newest":
             self.adsSortedList = self.arrOfAdViewModel.sorted{
                $0.advertisementDate > $1.advertisementDate
                }
        case "Oldest":
             self.adsSortedList = self.arrOfAdViewModel.sorted{
                $0.advertisementDate < $1.advertisementDate
                }
        default:
            print("default")
        }
         return self.adsSortedList
    }
    
    func showSortingAlert(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
             alert.addAction(UIAlertAction(title: "Price(High)", style: .default , handler:{ (UIAlertAction)in
                 self.isSorting = "High Price"
                 self.searchCollectionView.reloadData()
             }))
             
             alert.addAction(UIAlertAction(title: "Price(Low)", style: .default , handler:{ (UIAlertAction)in
                 self.isSorting = "Low Price"
                 self.searchCollectionView.reloadData()
             }))
             
             alert.addAction(UIAlertAction(title: "Newest", style: .default , handler:{ (UIAlertAction)in
                 self.isSorting = "Newest"
                 self.searchCollectionView.reloadData()
             }))
             
             alert.addAction(UIAlertAction(title: "Oldest", style: .default , handler:{ (UIAlertAction)in
                 self.isSorting = "Oldest"
                 self.searchCollectionView.reloadData()
             }))
             alert.addAction(UIAlertAction(title: "Default", style: .default , handler:{ (UIAlertAction)in
                 self.isSorting = "default"
                 self.searchCollectionView.reloadData()
             }))
             
             alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                
             }))
             
             self.present(alert, animated: true, completion: {
             })
    }
    
}
