//
//  CoreDataViewModel.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/23/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation

class CoreDataViewModel{
    
    private var dataAccess : CoreDataAccess
    
    init(dataAccess : CoreDataAccess ) {
        self.dataAccess = dataAccess
    }
    
    func addAdvertismentToFavourite(id :String){
        dataAccess.addToFavourite(id: id)
    
    }

    func isAdvertismentExist (id:String)->Bool{
        
        return dataAccess.isIdExist(id: id)
    }
    func deleteAdvertismentFromFavourite (id : String){
        dataAccess.deleteFromFavourite(id: id)
        
    }
    
    func checkNumberOfAdvertisment()->Bool{
        return dataAccess.checkNumOfAds()
    }
    
    func getAllFavouriteAdvertisment () -> [String]{
        return dataAccess.getAllAdvertisment()
    }
 
    
}




