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

    func addTofavourite(id : String)
    {
        let allData = getAllPropertiesFromCoreData()
        if (allData.count < 5){
            let newProperty = PropertyEntity(context: managedContext)
            newProperty.advertismentId = id
            self.saveChangesOfCoredata()
        }
        else{
            print("you have maximum 5 Advertisment")
        }
        
    }
    
    func getAllPropertiesFromCoreData()-> [NSManagedObject]{
        
        do{
            Properties =  try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("  getAllPropertiesFromCoreData       \(error)")
        }
        return Properties
    }
    
    func deleteFromFav(id : String)
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PropertyEntity")
        let predicate = NSPredicate(format: "advertismentId == %@", id)
        request.predicate = predicate
        if let result = try? managedContext.fetch(request) {
            for object in result {
                managedContext.delete(object as! NSManagedObject)
            }
        }
       self.saveChangesOfCoredata()
    }
    
    func saveChangesOfCoredata(){
        do{
            try managedContext.save()
        }
        catch let error as NSError{
            print("del saving in core data in addToProperties: \(error)")
        }
    }
    
    func checkValue (id:String)->Int{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PropertyEntity")
        let predicate = NSPredicate(format: "advertismentId == %@", id)
        request.predicate = predicate
        do{
            let count = try managedContext.count(for: request)
            if(count == 0){
                print("no matching object")
            }
            else{
                print("matching object exists")
                return count
            }
        }
        catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return 0
    }
    
    func getAllStored () -> [String]{
        var propertyArray = [PropertyEntity]()
        var PropertyOfStrings: [String]!
        let request : NSFetchRequest<PropertyEntity> = PropertyEntity.fetchRequest()
        do{
            propertyArray = try managedContext.fetch(request)
            for index in 0 ..< propertyArray.count{
                PropertyOfStrings[index] = propertyArray[index].advertismentId!
            }
        }catch let error as NSError {
            print("Could not fetch \(error)")
        }
        
        return PropertyOfStrings
    }


}
