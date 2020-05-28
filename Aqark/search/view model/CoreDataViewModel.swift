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
    
    func addPropertyToFavourite(id :String){
        let addToFav = dataAccess.addTofavourite(id: id)
    
    }

    func checkFav (id:String)->Int{
        let check = dataAccess.checkValue(id: id)
        return check
    }
    func deleteFromFavou (id : String){
        let remove = dataAccess.deleteFromFav(id: id)
        
    }
 
    
}




