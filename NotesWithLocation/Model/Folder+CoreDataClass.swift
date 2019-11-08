//
//  Folder+CoreDataClass.swift
//  NotesWithLocation
//
//  Created by Arseny Neustroev on 02/11/2019.
//  Copyright © 2019 Arseny Neustroev. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Folder)
public class Folder: NSManagedObject {
    class func NewFolder(name: String) -> Folder {
        let folder = Folder(context: CoreDataManager.sharedInstance.managedObjectContext)
        folder.name = name
        folder.dataModified = Date()
        return folder
    }
    
    func AddNote(noteName : String) -> Note{
        let note = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
        note.name = noteName
        note.folder = self
        note.dateModified = Date()
        return note
    }
}
