//
//  AdminAdvertisementsListViewModel.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/23/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import ReachabilitySwift

class AdminAdvertisementsListViewModel{
    
    var adminAdvertisementsViewList : [AdminAdvertisementViewModel] = [AdminAdvertisementViewModel]()
    var adminFreeAdvertisementsList : [AdminAdvertisementViewModel] = [AdminAdvertisementViewModel]()
    var adminPremiumAdvertisementsList : [AdminAdvertisementViewModel] = [AdminAdvertisementViewModel]()
    var dataAccess : AdminDataAccess!
    
    init(dataAccess:AdminDataAccess) {
        self.dataAccess = dataAccess
    }
    
    func populateAdvertisements(completionForPopulateAdvertisements:@escaping(_ totalAdvertisementsNumber:Int) -> Void){
        dataAccess.getAdvertisements { [weak self] (advertisementsData) in
            self?.adminFreeAdvertisementsList.removeAll()
            self?.adminPremiumAdvertisementsList.removeAll()
            self?.filter(allAdvertisementsData: advertisementsData)
            //            self.adminAdvertisementsList = advertisementsData.map{ (advertisementData) in
            //                return AdminAdvertisementViewModel(adminAdvertisment: advertisementData)
            //            }
            //            self.adminAdvertisementsViewList = self.adminAdvertisementsList
            completionForPopulateAdvertisements(advertisementsData.count)
        }
    }
    
    func filter(allAdvertisementsData : [AdminAdvertisement]){
        for advertisement in allAdvertisementsData{
            switch advertisement.advertisementPaymentType.lowercased() {
            case AdvertisementPaymentType.free:
                let freeAdvertisement = AdminAdvertisementViewModel(adminAdvertisment: advertisement)
                adminFreeAdvertisementsList.append(freeAdvertisement)
            default:
                let premiumAdvertisement = AdminAdvertisementViewModel(adminAdvertisment: advertisement)
                adminPremiumAdvertisementsList.append(premiumAdvertisement)
            }
        }
        adminAdvertisementsViewList = adminFreeAdvertisementsList
    }
    
    func getAdvertisementsByType(type:Int){
        switch type {
        case 0:
            adminAdvertisementsViewList = adminFreeAdvertisementsList
        default:
            adminAdvertisementsViewList = adminPremiumAdvertisementsList
        }
    }
    
    func getFilteredAdvertisements(searchText:String,type:Int){
        if(searchText.isEmpty){
            getAdvertisementsByType(type: type)
        }else{
            switch type{
            case 0:
                adminAdvertisementsViewList = adminFreeAdvertisementsList.filter{ (advertisement:AdminAdvertisementViewModel) -> Bool in
                    let ad = advertisement
                    if(ad.advertisementId.lowercased().contains(searchText.lowercased())){
                        return advertisement.advertisementId.lowercased().contains(searchText.lowercased())
                    }else{
                        return advertisement.advertisementPropertyAddress.lowercased().contains(searchText.lowercased())
                    }
                }
            default:
                adminAdvertisementsViewList = adminPremiumAdvertisementsList.filter{ (advertisement:AdminAdvertisementViewModel) -> Bool in
                    let ad = advertisement
                    if(ad.advertisementId.lowercased().contains(searchText.lowercased())){
                        return advertisement.advertisementId.lowercased().contains(searchText.lowercased())
                    }else{
                        return advertisement.advertisementPropertyAddress.lowercased().contains(searchText.lowercased())
                    }
                }
            }
        }
        
    }
    
    func getReportedAdvertisementPaymentType(reportedAdvertisementId:String) -> String{
        
        adminAdvertisementsViewList = adminFreeAdvertisementsList.filter{
            $0.advertisementId == reportedAdvertisementId}
        if(adminAdvertisementsViewList.count == 1){
            return "free"
        }
        
        adminAdvertisementsViewList = adminPremiumAdvertisementsList.filter{
            $0.advertisementId == reportedAdvertisementId}
        if(adminAdvertisementsViewList.count == 1){
            return "premium"
        }
        return "deleted"
    }
    
    func deleteAdvertisement(adminAdvertisement:AdminAdvertisementViewModel,completionForDeleteAdvertisement:@escaping(_ deleted:Bool)->Void){
        dataAccess.deleteAdvertisment(adminAdvertisement: adminAdvertisement){(deleted) in
            completionForDeleteAdvertisement(deleted)
        }
    }
    
    func removeAdvertisementsObservers(){
        dataAccess.removeAdvertisementsObservers()
        dataAccess = nil
    }
    
}
