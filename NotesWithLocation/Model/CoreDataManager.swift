//
//  CoreDataManager.swift
//  NotesWithLocation
//
//  Created by Arseny Neustroev on 02/11/2019.
//  Copyright © 2019 Arseny Neustroev. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static let sharedInstance = CoreDataManager()
    
    var folders: [Folder] {
        let request = NSFetchRequest<Folder>(entityName: "Folder")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        let array = try? CoreDataManager.sharedInstance.managedObjectContext.fetch(request)
        if array != nil{
            return array!
        }
        return []
        
    }
    
    var notes: [Note] {
        let request = NSFetchRequest<Note>(entityName: "Note")
        let sortDescriptor = NSSortDescriptor(key: "dateModified", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        let array = try? CoreDataManager.sharedInstance.managedObjectContext.fetch(request)
        if array != nil{
            return array!
        }
        return []
        
    }
    
    var managedObjectContext : NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NotesWithLocation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}
