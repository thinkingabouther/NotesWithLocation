//
//  Note+CoreDataClass.swift
//  NotesWithLocation
//
//  Created by Arseny Neustroev on 02/11/2019.
//  Copyright © 2019 Arseny Neustroev. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Note)
public class Note: NSManagedObject {
    
    class func NewNote(noteName : String) -> Note {
        let note = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
        note.name = noteName
        note.dateModified = Date()
        return note
    }
    
    func addImage(image : UIImage) {
        let noteImage = NoteImage(context: CoreDataManager.sharedInstance.managedObjectContext)
        noteImage.imageBig = image.jpegData(compressionQuality: 1)
        self.image = noteImage
    }
    
    func addLocation(lat : Double, lon : Double) {
        let location = Location(context: CoreDataManager.sharedInstance.managedObjectContext)
        location.lat = lat
        location.lon = lon
        self.location = location
    }
}
