//
//  CoreDataAccess.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/23/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataAccess: NSObject{
    var Properties:[NSManagedObject] = []
    let appDelegate:AppDelegate
    let managedContext:NSManagedObjectContext
    let fetchRequest:NSFetchRequest<NSManagedObject>
    
    override init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PropertyEntity")
    }

    func addToFavourite(id : String)
    {
        let newProperty = PropertyEntity(context: managedContext)
        newProperty.advertismentId = id
        self.saveChangesToCoredata()
    }
    
    func deleteFromFavourite(id : String)
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PropertyEntity")
        let predicate = NSPredicate(format: "advertismentId == %@", id)
        request.predicate = predicate
        if let result = try? managedContext.fetch(request) {
            for object in result {
                managedContext.delete(object as! NSManagedObject)
            }
        }
        self.saveChangesToCoredata()
    }
    
    func getAllAdvertisment()-> [String]{
        
        do{
            Properties =  try managedContext.fetch(fetchRequest)
        }catch let error as NSError{
            print("getAllPropertiesFromCoreData \(error)")
        }
        let adArray = convertToStringArray(myArray: Properties)
        return adArray
    }
    
    func checkNumOfAds() -> Bool{
        let allData = getAllAdvertisment()
         print(" count in coredata \(allData.count)")
        if (allData.count < 20){
            return true
        }
        return false
    }
    
    func isIdExist (id:String)->Bool{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PropertyEntity")
        let predicate = NSPredicate(format: "advertismentId == %@", id)
        request.predicate = predicate
        do{
            let count = try managedContext.count(for: request)
            if(count == 0){
                print("no matching object exists")
                return false
            }
            else{
                print("matching object exists")
                return true
            }
        }
        catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return false
    }
    
    func convertToStringArray(myArray: [NSManagedObject]) -> [String] {
        var stringArray: [String] = []
        for item in myArray {
            var str : String = ""
            for attribute in item.entity.attributesByName {
                if let value = item.value(forKey: attribute.key) {
                    str = value as! String
                }
            }
            stringArray.append(str)
        }
        return stringArray
    }
    
    func saveChangesToCoredata(){
        do{
            try managedContext.save()
        }
        catch let error as NSError{
            print(" saving in core data : \(error)")
        }
    }

}
