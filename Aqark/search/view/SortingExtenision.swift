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
        isSorted = true
        switch str {
        case "High Price":
            if isFiltering == true {
                self.adsSortedList = self.filteredAdsList.sorted{
                $0.price > $1.price
                }
                }else{
                    self.adsSortedList = self.arrOfAdViewModel.sorted{
                                   $0.price > $1.price
                                   
                }
            }
        case "Low Price":
            self.adsSortedList = self.arrOfAdViewModel.sorted{
                $0.price < $1.price
                }
            if isFiltering == true {
            self.adsSortedList = self.filteredAdsList.sorted{
            $0.price < $1.price
            }
            }
        case "Newest":
             self.adsSortedList = self.arrOfAdViewModel.sorted{
                $0.advertisementDate > $1.advertisementDate
                }
                if isFiltering == true {
                self.adsSortedList = self.filteredAdsList.sorted{
                  $0.advertisementDate > $1.advertisementDate
                }
            }
        case "Oldest":
             self.adsSortedList = self.arrOfAdViewModel.sorted{
                $0.advertisementDate < $1.advertisementDate
                }
                    if isFiltering == true {
                    self.adsSortedList = self.filteredAdsList.sorted{
                  $0.advertisementDate < $1.advertisementDate
                    }
            }
        default:
            print("default")
        }
         return self.adsSortedList
    }
    
     @objc  func showSortingAlert(){
//        print(isFiltering)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Price(High)".localize, style: .default , handler:{ [weak self] (UIAlertAction)in
            self?.isSorting = "High Price"
            self?.isSorted = true
                 self?.searchCollectionView.reloadData()
             }))
             
        alert.addAction(UIAlertAction(title: "Price(Low)".localize, style: .default , handler:{[weak self] (UIAlertAction)in
                 self?.isSorting = "Low Price"
                 self?.searchCollectionView.reloadData()
             }))
             
        alert.addAction(UIAlertAction(title: "Newest".localize, style: .default , handler:{ [weak self] (UIAlertAction)in
                 self?.isSorting = "Newest"
                 self?.searchCollectionView.reloadData()
             }))
             
        alert.addAction(UIAlertAction(title: "Oldest".localize, style: .default , handler:{ [weak self] (UIAlertAction)in
                 self?.isSorting = "Oldest"
                 self?.searchCollectionView.reloadData()
             }))
             
        alert.addAction(UIAlertAction(title: "Cancel".localize, style: .cancel, handler:{ (UIAlertAction)in
                
             }))
             
             self.present(alert, animated: true, completion: {
             })
    }
    
}
