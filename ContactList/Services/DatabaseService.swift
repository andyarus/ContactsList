//
//  DatabaseService.swift
//  ContactList
//
//  Created by Andrei Coder on 17/10/2019.
//  Copyright © 2019 yaav. All rights reserved.
//

import UIKit
import CoreData

class DatabaseService: DatabaseServiceProtocol {
  
  static let shared = DatabaseService()
  
  private init() { }
  
  func createData(for entity: Entity) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedObjectContext = appDelegate.persistentContainer.viewContext

    guard let entityDescription = NSEntityDescription.entity(forEntityName: entity.name(), in: managedObjectContext) else { return }
    let managedObject = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)

    switch entity {
    case .colleague(let colleague):
      guard let colleague = colleague else { return }
      managedObject.setValue(colleague.firstName, forKeyPath: "firstName")
      managedObject.setValue(colleague.lastName, forKeyPath: "lastName")
      managedObject.setValue(colleague.middleName, forKeyPath: "middleName")
      managedObject.setValue(colleague.phone, forKeyPath: "phone")
      managedObject.setValue(colleague.workPhone, forKeyPath: "workPhone")
      managedObject.setValue(colleague.position, forKeyPath: "position")
      let photo = colleague.photo != .defaultPhoto ? colleague.photo?.jpegData(compressionQuality: 1.0) : nil
      managedObject.setValue(photo, forKeyPath: "photo")
    case .friend(let friend):
      guard let friend = friend else { return }
      managedObject.setValue(friend.firstName, forKeyPath: "firstName")
      managedObject.setValue(friend.lastName, forKeyPath: "lastName")
      managedObject.setValue(friend.middleName, forKeyPath: "middleName")
      managedObject.setValue(friend.phone, forKeyPath: "phone")
      managedObject.setValue(friend.birthday, forKeyPath: "birthday")
      let photo = friend.photo != .defaultPhoto ? friend.photo?.jpegData(compressionQuality: 1.0) : nil
      managedObject.setValue(photo, forKeyPath: "photo")
    }

    do {
      try managedObjectContext.save()
    } catch {
      print("Data creation failed: \(error)")
    }
  }
  
  func retrieveData(all entity: Entity) -> [Entity] {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name())
//    fetchRequest.fetchLimit = 1
//    fetchRequest.predicate = NSPredicate(format: "phone = %@", "911")
//    fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "firstName", ascending: false)]

    var entities: [Entity] = []
    var retrievedEntity: Entity
    
    do {
      let result = try managedContext.fetch(fetchRequest)
      guard let managedObjects = result as? [NSManagedObject] else { return [] }
      for managedObject in managedObjects {
        switch entity {
        case .colleague:
          guard let firstName = managedObject.value(forKey: "firstName") as? String,
            let lastName = managedObject.value(forKey: "lastName") as? String,
            let middleName = managedObject.value(forKey: "middleName") as? String,
            let phone = managedObject.value(forKey: "phone") as? String,
            let workPhone = managedObject.value(forKey: "workPhone") as? String,
            let position = managedObject.value(forKey: "position") as? String else { continue }
          
          let photoData = managedObject.value(forKey: "photo") as? Data
          
          let colleague = Colleague(firstName: firstName,
                                    lastName: lastName,
                                    middleName: middleName,
                                    photo: photoData != nil ? UIImage(data: photoData!) : nil,
                                    phone: phone,
                                    workPhone: workPhone,
                                    position: position,
                                    key: phone)
          
          retrievedEntity = .colleague(colleague)
        case .friend:
          guard let firstName = managedObject.value(forKey: "firstName") as? String,
            let lastName = managedObject.value(forKey: "lastName") as? String,
            let middleName = managedObject.value(forKey: "middleName") as? String,
            let phone = managedObject.value(forKey: "phone") as? String,
            let birthday = managedObject.value(forKey: "birthday") as? Date else { continue }
          
          let photoData = managedObject.value(forKey: "photo") as? Data
          
          let friend = Friend(firstName: firstName,
                                    lastName: lastName,
                                    middleName: middleName,
                                    photo: photoData != nil ? UIImage(data: photoData!) : nil,
                                    phone: phone,
                                    birthday: birthday,
                                    key: phone)
          
          retrievedEntity = .friend(friend)
        }
        
        entities.append(retrievedEntity)
      }
    } catch {
      print("Data retrieving failed: \(error)")
    }
    
    return entities
  }
  
  func retrieveData(by key: String, one entity: Entity) -> Entity? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entity.name())
    fetchRequest.predicate = NSPredicate(format: "phone = %@", key)
    
    do {
      let result = try managedContext.fetch(fetchRequest)      
      guard let managedObjects = result as? [NSManagedObject],
        let managedObject = managedObjects.first else { return nil }

      switch entity {
      case .colleague:
        guard let firstName = managedObject.value(forKey: "firstName") as? String,
          let lastName = managedObject.value(forKey: "lastName") as? String,
          let middleName = managedObject.value(forKey: "middleName") as? String,
          let phone = managedObject.value(forKey: "phone") as? String,
          let workPhone = managedObject.value(forKey: "workPhone") as? String,
          let position = managedObject.value(forKey: "position") as? String else { return nil }
        
        let photoData = managedObject.value(forKey: "photo") as? Data
        
        let colleague = Colleague(firstName: firstName,
                                  lastName: lastName,
                                  middleName: middleName,
                                  photo: photoData != nil ? UIImage(data: photoData!) : nil,
                                  phone: phone,
                                  workPhone: workPhone,
                                  position: position,
                                  key: phone)
        
        return .colleague(colleague)
      case .friend:
        guard let firstName = managedObject.value(forKey: "firstName") as? String,
          let lastName = managedObject.value(forKey: "lastName") as? String,
          let middleName = managedObject.value(forKey: "middleName") as? String,
          let phone = managedObject.value(forKey: "phone") as? String,
          let birthday = managedObject.value(forKey: "birthday") as? Date else { return nil }
        
        let photoData = managedObject.value(forKey: "photo") as? Data
        
        let friend = Friend(firstName: firstName,
                            lastName: lastName,
                            middleName: middleName,
                            photo: photoData != nil ? UIImage(data: photoData!) : nil,
                            phone: phone,
                            birthday: birthday,
                            key: phone)
        
        return .friend(friend)
      }
    } catch {
      print("Data retrieving failed: \(error)")
    }
    
    return nil
  }
  
  func updateData(by key: String, with entity: Entity) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedObjectContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entity.name())
    fetchRequest.predicate = NSPredicate(format: "phone = %@", key)
    
    do {
      let result = try managedObjectContext.fetch(fetchRequest)
      guard let managedObjects = result as? [NSManagedObject],
        let managedObject = managedObjects.first else { return }
      
      switch entity {
      case .colleague(let colleague):
        guard let colleague = colleague else { return }
        managedObject.setValue(colleague.firstName, forKeyPath: "firstName")
        managedObject.setValue(colleague.lastName, forKeyPath: "lastName")
        managedObject.setValue(colleague.middleName, forKeyPath: "middleName")
        managedObject.setValue(colleague.phone, forKeyPath: "phone")
        managedObject.setValue(colleague.workPhone, forKeyPath: "workPhone")
        managedObject.setValue(colleague.position, forKeyPath: "position")
        let photo = colleague.photo?.jpegData(compressionQuality: 1.0)
        managedObject.setValue(photo, forKeyPath: "photo")
      case .friend(let friend):
        guard let friend = friend else { return }
        managedObject.setValue(friend.firstName, forKeyPath: "firstName")
        managedObject.setValue(friend.lastName, forKeyPath: "lastName")
        managedObject.setValue(friend.middleName, forKeyPath: "middleName")
        managedObject.setValue(friend.phone, forKeyPath: "phone")
        managedObject.setValue(friend.birthday, forKeyPath: "birthday")
        let photo = friend.photo?.jpegData(compressionQuality: 1.0)
        managedObject.setValue(photo, forKeyPath: "photo")
      }
      
      try managedObjectContext.save()
    } catch {
      print("Data updating failed: \(error)")
    }
  }
  
  // remove data by key
  func deleteData(by key: String, for entity: Entity) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedObjectContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name())
    fetchRequest.predicate = NSPredicate(format: "phone = %@", key)
    
    do {
      let result = try managedObjectContext.fetch(fetchRequest)
      guard let managedObjects = result as? [NSManagedObject],
        let managedObject = managedObjects.first else { return }
      
      managedObjectContext.delete(managedObject)

      try managedObjectContext.save()
    } catch {
      print("Data deletion failed: \(error)")
    }
  }
  
  // remove all data
  func deleteData(all entity: Entity) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedObjectContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name())
    
    do {
      let result = try managedObjectContext.fetch(fetchRequest)
      guard let managedObjects = result as? [NSManagedObject] else { return }
      
      for managedObject in managedObjects {
        managedObjectContext.delete(managedObject)
      }
      
      try managedObjectContext.save()
    } catch {
      print("Data deletion failed: \(error)")
    }
  }

}
