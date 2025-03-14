//
//  ContactController.swift
//  Telefgramme
//
//  Created by Brian Chew on 21/11/19.
//  Copyright © 2019 Brian Chew. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContactController{
    
    
    func AddContact(newContact:Contact){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "CDContact", in: context)!
        let contact = NSManagedObject(entity: entity, insertInto: context)
        contact.setValue(newContact.firstName,forKeyPath:"firstname")
        contact.setValue(newContact.lastName,forKeyPath:"lastname")
        contact.setValue(newContact.mobileNo,forKeyPath:"mobileno")
        contact.setValue(newContact.nickName,forKeyPath:"nickname")

        
        do{
            try context.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }

    }
    
    
    
//    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Device")
//    do {
//        if let results = try persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject] {
//            for result in results {
//                if let name = result.value(forKey: "name") as? String, let type = result.value(forKey: "type") as? String {
//                    print(name, "is an ", type)
//                }
//            }
//        }
//    } catch {
//        print("Failed to fetch data request.")
//    }
    
    
    
    
    
//    func retrieveAllContact()->[Contact]{
//        var contactList:[Contact] = []
//
//        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDContact")
//        do {
//            if let contacts = try context.fetch(fetchRequest) as? [NSManagedObject]{
//                for c in contacts{
//                    let firstname = c.value(forKeyPath: "firstname") as? String
//                    let lastname = c.value(forKeyPath: "lastname") as? String
//                    let mobileno = c.value(forKeyPath: "mobileno") as? String
//                    print("\(firstname!),\(lastname!),\(mobileno!)")
//                    contactList.append(Contact(firstname: firstname!, lastname: lastname!, mobileno: mobileno!))
//                }
//            }
//
//        }catch {
//            print("could not fetch data")
//        }
//        return contactList
//    }

    
    func retrieveAllContact()->[Contact]{
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var contact:[NSManagedObject] = []
        var contactList:[Contact] = []
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        do {
            contact = try context.fetch(fetchRequest)
            
            for c in contact {
                let firstname = c.value(forKey: "firstname") as? String
                let lastname = c.value(forKey: "lastname") as? String
                let mobileno = c.value(forKey: "mobileno") as? String
                let nickname = c.value(forKey: "nickname") as? String

                
                contactList.append(Contact(firstname: firstname!, lastname: lastname!, mobileno: mobileno!, nickname: nickname!))
                print("\(firstname!) \(lastname!), \(mobileno!) \(nickname!)")
            }
        } catch let error as NSError {
            print ("Could not fetch. \(error), \(error.userInfo)")
        }
        return contactList
    }
    
    
    
    
    
    
    
    func updateContact(mobileno:String, newContact:Contact){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        fetchRequest.predicate = NSPredicate(format: "mobileno = %@", mobileno)
        do
        {
            let test = try context.fetch(fetchRequest)
            
            let objectUpdate = test[0]
            objectUpdate.setValue(newContact.firstName, forKey: "firstname")
            objectUpdate.setValue(newContact.lastName, forKey: "lastname")
            objectUpdate.setValue(newContact.mobileNo, forKey: "mobileno")
            do{
                try context.save()
            }
            catch{
                print(error)
            }

        }
        catch{
            print(error)
        }
    }

    func deleteContact(mobileno:String){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        fetchRequest.predicate = NSPredicate(format: "mobileno = %@", mobileno)

        do{
            let test = try context.fetch(fetchRequest)
            let objectToDelete = test[0]
                context.delete(objectToDelete)
        }
        catch{
            print(error)
        }
    }
}



