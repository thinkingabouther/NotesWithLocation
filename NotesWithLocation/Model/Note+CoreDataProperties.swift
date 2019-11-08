//
//  Note+CoreDataProperties.swift
//  NotesWithLocation
//
//  Created by Arseny Neustroev on 02/11/2019.
//  Copyright © 2019 Arseny Neustroev. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var dateModified: Date?
    @NSManaged public var imageSmall: Data?
    @NSManaged public var name: String?
    @NSManaged public var textDescription: String?
    @NSManaged public var folder: Folder?
    @NSManaged public var image: NoteImage?
    @NSManaged public var location: Location?

}
