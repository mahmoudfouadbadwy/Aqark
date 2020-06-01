//
//  AdminAdvertisementsListViewModel.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/23/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
class AdminAdvertisementsListViewModel{
    
    var adminAdvertisementsViewList : [AdminAdvertisementViewModel] = [AdminAdvertisementViewModel]()
    var adminAdvertisementsList : [AdminAdvertisementViewModel] = [AdminAdvertisementViewModel]()
    var adminFilteredAdvertisementsList : [AdminAdvertisementViewModel] = [AdminAdvertisementViewModel]()
    let dataAccess : AdminDataAccess!
    
    init(dataAccess:AdminDataAccess) {
        self.dataAccess = dataAccess
    }
    
    func populateAdvertisements(completionForPopulateAdvertisements:@escaping() -> Void){
        dataAccess.getAdvertisements { (advertisementsData) in
            self.adminAdvertisementsList = advertisementsData.map{ (advertisementData) in
                        return AdminAdvertisementViewModel(adminAdvertisment: advertisementData)
            }
            self.adminAdvertisementsViewList = self.adminAdvertisementsList
            completionForPopulateAdvertisements()
        }
    }
    
    func getFilteredAdvertisements(searchText:String){
        if(searchText.isEmpty){
            adminAdvertisementsViewList = adminAdvertisementsList
        }else{
            adminAdvertisementsViewList = adminAdvertisementsList.filter{ (advertisement:AdminAdvertisementViewModel) -> Bool in
                let ad = advertisement
                if(ad.advertisementId.lowercased().contains(searchText.lowercased())){
                    return advertisement.advertisementId.lowercased().contains(searchText.lowercased())
                }else{
                    return advertisement.advertisementPropertyAddress.lowercased().contains(searchText.lowercased())
                }
            }
        }
    }
    
    func deleteAdvertisement(adminAdvertisement:AdminAdvertisementViewModel){
        dataAccess.deleteAdvertisment(adminAdvertisement: adminAdvertisement)
    }
}
