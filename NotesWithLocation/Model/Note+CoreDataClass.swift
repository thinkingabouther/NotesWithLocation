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
    
    var actualBigImage : UIImage? {
        set{
            if newValue == nil { // deteting an image
                if self.image != nil{
                    CoreDataManager.sharedInstance.managedObjectContext.delete(self.image!)
                }
                self.imageSmall = nil
            }
            else{ // inserting new image
                if self.image == nil{ // if object is new to database
                    self.image = NoteImage(context: CoreDataManager.sharedInstance.managedObjectContext)
                }
                self.image?.imageBig = newValue?.jpegData(compressionQuality: 1)
                self.imageSmall = newValue?.jpegData(compressionQuality: 0.05)
            }
            dateModified = Date()
        }
        get{
            if self.image != nil && self.image?.imageBig != nil{
                return UIImage(data: self.image!.imageBig!)
            }
            return nil
            
        }
    }
    
    var actualSmallImage : UIImage?{
        get {
            if self.imageSmall != nil{
                return UIImage(data: self.imageSmall!)
            }
            return nil
        }
    }
    
    var dateModifiedString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: self.dateModified!)
    }
    
    class func NewNote(noteName : String, inFolder : Folder?) -> Note {
        let note = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
        note.name = noteName
        note.dateModified = Date()
        note.folder = inFolder

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
