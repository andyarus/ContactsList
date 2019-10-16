//
//  DatabaseService.swift
//  ContactList
//
//  Created by Andrei Coder on 17/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import UIKit
import CoreData

class DatabaseService {
  
  func createData(for entity: Entity, with data: Colleague) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
//    guard let colleagueEntity = NSEntityDescription.entity(forEntityName: entity.rawValue, in: managedContext) else { return }
//    
//    let colleagueObject = NSManagedObject(entity: colleagueEntity, insertInto: managedContext)
//    colleagueObject.setValue(colleague.firstName, forKeyPath: "firstName")
//    colleagueObject.setValue(colleague.lastName, forKeyPath: "lastName")
//    colleagueObject.setValue(colleague.middleName, forKeyPath: "middleName")
//    colleagueObject.setValue(colleague.phone, forKeyPath: "phone")
//    colleagueObject.setValue(colleague.workPhone, forKeyPath: "workPhone")
//    colleagueObject.setValue(colleague.position, forKeyPath: "position")
//
//    let photo = colleague.photo?.jpegData(compressionQuality: 1.0)
//    colleagueObject.setValue(photo, forKeyPath: "photo")
//    
//    print("colleagueObject:\(colleagueObject)")
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
  
  func retrieveData() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ColleagueEntity")
    
    //        fetchRequest.fetchLimit = 1
    //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
    //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
    //
    do {
      let result = try managedContext.fetch(fetchRequest)
      for data in result as! [NSManagedObject] {
        print(data)
        //print(data.value(forKey: "username") as! String)
      }
    } catch {
      print(error)
    }
  }
  
  func updateData(for colleague: Colleague) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "ColleagueEntity")
    fetchRequest.predicate = NSPredicate(format: "phone = %@", "911")
    
    do {
      let test = try managedContext.fetch(fetchRequest)
      
//      let objectUpdate = test[0] as! NSManagedObject
//      objectUpdate.setValue("newName", forKey: "username")
//      objectUpdate.setValue("newmail", forKey: "email")
//      objectUpdate.setValue("newpassword", forKey: "password")
      
      let colleagueObject = test[0] as! NSManagedObject
      colleagueObject.setValue(colleague.firstName, forKeyPath: "firstName")
      colleagueObject.setValue(colleague.lastName, forKeyPath: "lastName")
      colleagueObject.setValue(colleague.middleName, forKeyPath: "middleName")
      colleagueObject.setValue(colleague.phone, forKeyPath: "phone")
      colleagueObject.setValue(colleague.workPhone, forKeyPath: "workPhone")
      colleagueObject.setValue(colleague.position, forKeyPath: "position")
      
      let photo = colleague.photo?.jpegData(compressionQuality: 1.0)
      colleagueObject.setValue(photo, forKeyPath: "photo")
      
      do {
        try managedContext.save()
      } catch {
        print(error)
      }
    } catch {
      print(error)
    }
  }
  
  func deleteData() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ColleagueEntity")
    fetchRequest.predicate = NSPredicate(format: "phone = %@", "911")
    
    do {
      let test = try managedContext.fetch(fetchRequest)
      
      let objectToDelete = test[0] as! NSManagedObject
      managedContext.delete(objectToDelete)
      
      do {
        try managedContext.save()
      } catch {
        print(error)
      }
    } catch {
      print(error)
    }
  }

}
